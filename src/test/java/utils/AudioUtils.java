package utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
//import java.io.OutputStream;
import java.math.BigDecimal;
//import java.math.RoundingMode;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.TargetDataLine;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;

import ai.rev.speechtotext.ApiClient;
import ai.rev.speechtotext.models.asynchronous.RevAiCaptionType;
import ai.rev.speechtotext.models.asynchronous.RevAiJob;
import ai.rev.speechtotext.models.asynchronous.RevAiJobOptions;
import ai.rev.speechtotext.models.asynchronous.RevAiJobStatus;
import ai.rev.speechtotext.models.asynchronous.RevAiTranscript;
import ai.rev.speechtotext.models.vocabulary.CustomVocabulary;
import org.sikuli.script.Finder;
import org.sikuli.script.Match;
import org.sikuli.script.Pattern;
import org.sikuli.script.Screen;

import com.musicg.fingerprint.FingerprintManager;
import com.musicg.fingerprint.FingerprintSimilarity;
import com.musicg.fingerprint.FingerprintSimilarityComputer;
import com.musicg.wave.Wave;

/**
 * 
 * @author chirag.s
 *
 */
public class AudioUtils {

	// format of audio file
	AudioFileFormat.Type fileType = AudioFileFormat.Type.WAVE;

	// the line from which audio data is captured
	TargetDataLine line;

	/**
	 * Defines an audio format
	 */
	AudioFormat getAudioFormat() {
		float sampleRate = 16000;
		int sampleSizeInBits = 8;
		int channels = 2;
		boolean signed = true;
		boolean bigEndian = true;
		AudioFormat format = new AudioFormat(sampleRate, sampleSizeInBits,
				channels, signed, bigEndian);
		return format;
	}

	/**
	 * Captures the sound and record into a WAV file
	 */
	public void start(File wavFile) {
		try {
			AudioFormat format = getAudioFormat();
			DataLine.Info info = new DataLine.Info(TargetDataLine.class, format);

			// checks if system supports the data line
			if (!AudioSystem.isLineSupported(info)) {
				System.out.println("Line not supported");
				System.exit(0);
			}
			line = (TargetDataLine) AudioSystem.getLine(info);
			line.open(format);
			line.start();   // start capturing

			System.out.println("Start capturing...");

			AudioInputStream ais = new AudioInputStream(line);

			System.out.println("Start recording...");

			// start recording
			AudioSystem.write(ais, fileType, wavFile);

		} catch (LineUnavailableException ex) {
			ex.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}

	/**
	 * Closes the target data line to finish capturing and recording
	 */
	public void finish() {
		line.stop();
		line.close();
		System.out.println("Finished");
	}

	public String convertSpeectToText(String localFile) throws IOException
	{
		// Assign your access token to a String
		String accessToken = "02A7Ehtg05em-RGYmpe40g5MHniCdNHEtY1tCz_WXcVCi1MxXNZ_pq03J4xUz28IjElcr2KVxOf3DnvGjSMunFBNGh4nk";

		// Initialize the ApiClient with your access token
		ApiClient apiClient = new ApiClient(accessToken);

		// Create a custom vocabulary for your submission
		CustomVocabulary customVocabulary =
				new CustomVocabulary(Arrays.asList("Chirag", "Evelina Fedorenko"));

		// Initialize the RevAiJobOptions object and assign
		RevAiJobOptions revAiJobOptions = new RevAiJobOptions();
		revAiJobOptions.setCustomVocabularies(List.of(customVocabulary));
		revAiJobOptions.setMetadata("My first submission");
		// revAiJobOptions.setCallbackUrl("https://example.com");
		revAiJobOptions.setSkipPunctuation(false);
		revAiJobOptions.setSkipDiarization(false);
		revAiJobOptions.setFilterProfanity(true);
		revAiJobOptions.setRemoveDisfluencies(true);
		revAiJobOptions.setSpeakerChannelsCount(null);
		revAiJobOptions.setDeleteAfterSeconds(2592000); // 30 days in seconds
		revAiJobOptions.setLanguage("en");

		RevAiJob submittedJob;

		try {
			// Submit the local file and transcription options
			submittedJob = apiClient.submitJobLocalFile(localFile, revAiJobOptions);
		} catch (IOException e) {
			throw new RuntimeException("Failed to submit file [" + localFile + "] " + e.getMessage());
		}
		String jobId = submittedJob.getJobId();
		System.out.println("Job Id: " + jobId);
		System.out.println("Job Status: " + submittedJob.getJobStatus());
		System.out.println("Created On: " + submittedJob.getCreatedOn());

		// Waits 5 seconds between each status check to see if job is complete
		boolean isJobComplete = false;
		while (!isJobComplete) {
			RevAiJob retrievedJob;
			try {
				retrievedJob = apiClient.getJobDetails(jobId);
			} catch (IOException e) {
				throw new RuntimeException("Failed to retrieve job [" + jobId + "] " + e.getMessage());
			}

			RevAiJobStatus retrievedJobStatus = retrievedJob.getJobStatus();
			if (retrievedJobStatus == RevAiJobStatus.TRANSCRIBED
					|| retrievedJobStatus == RevAiJobStatus.FAILED) {
				isJobComplete = true;
			} else {
				try {
					Thread.sleep(5000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}

		// Get the transcript and caption outputs
		RevAiTranscript objectTranscript;
		String textTranscript = null;
		InputStream srtCaptions;
		InputStream vttCaptions;

		try {
			objectTranscript = apiClient.getTranscriptObject(jobId);
			textTranscript = apiClient.getTranscriptText(jobId);
			System.out.println(textTranscript);
			srtCaptions = apiClient.getCaptions(jobId, RevAiCaptionType.SRT);
			vttCaptions = apiClient.getCaptions(jobId, RevAiCaptionType.VTT);
		} catch (IOException e) {
			e.printStackTrace();
		}
		apiClient.deleteJob(jobId);
		
		return textTranscript;
	}
	
	public BigDecimal compare(int exp,int act,String path) throws IOException
	{
//		Screen screen=new Screen();
//		Pattern pa1=new Pattern(path+"Exp_"+exp+".jpg");
		Pattern pa1=new Pattern(path+"Act_"+exp+".jpg");
		BigDecimal score = null;
		//Finder f1=new Finder(screen.capture().getImage());
		 Finder f1=new Finder(path+"Act_"+act+".jpg");
		try {
			 f1.find(pa1);
				if(f1.hasNext()){

					Match m=f1.next();
					//score = BigDecimal.valueOf((m.getScore()*100)).setScale(2, RoundingMode.HALF_UP);
					//System.out.println("Match found with "+exp+" image "+(m.getScore()*100)+"%");
					f1.destroy();
				}
				else{

					System.out.println("No Match Found");
				}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return score;
	}
	
	public String readFileAsString(String fileName)throws Exception
	{
		String data = "";
		data = new String(Files.readAllBytes(Paths.get(fileName)));
		return data;
	}
	
	public void getScreenshotDriver(String fileWithPath,WebDriver webdriver) throws IOException
	{
		TakesScreenshot scrShot =((TakesScreenshot)webdriver);
		File SrcFile=scrShot.getScreenshotAs(OutputType.FILE);
		File DestFile=new File(fileWithPath);
		FileUtils.copyFile(SrcFile, DestFile);
	}

	public boolean getFingerPrintBySound(String expFile,String actualFile)
	{
		 byte[] firstFingerPrint = new FingerprintManager().extractFingerprint(new Wave(expFile));
		 byte[] secondFingerPrint = new FingerprintManager().extractFingerprint(new Wave(actualFile));
		 // Compare fingerprints
		 FingerprintSimilarity fingerprintSimilarity = new FingerprintSimilarityComputer(firstFingerPrint, secondFingerPrint).getFingerprintsSimilarity();
		 System.out.println("score = " + fingerprintSimilarity.getScore());
		 float scrore = fingerprintSimilarity.getSimilarity();
		 System.out.println("Similarity score = " + scrore);
        return scrore == 1.0f;
    }
}
