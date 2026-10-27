package utils;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


public class Test4 {

    public static void main(String[] args) {
       UpdateUtils( ".\\src\\test\\java\\testScript\\Sample.java",9);

        System.out.println("done");
    }

    public static void RunRandom() {
        UpdateUtils( ".\\src\\test\\java\\testScript\\Sample.java",9);
        System.out.println("done");
    }
    public static void UpdateUtils(String filePath,int matchingIndexPattern) {
        int Regression_Count = 0;
        try {
            String Current_Count= readproperty("Regression_Count");
            Regression_Count = Integer.parseInt(Current_Count)+1;
            String s=String.valueOf(Regression_Count);
            updateproprtywithvalue("Regression_Count",s);
        } catch (IOException e) {
            e.printStackTrace();
        }

        ArrayList<String> ExecutedScenerio = new ArrayList<>();
        ArrayList<String> AllScenerioTag = new ArrayList<>();

        ArrayList<String> FinalTestToExecute = new ArrayList<>();
        ArrayList<String> FinalTestToExecuteDuplicate = new ArrayList<>();

        String[] Order_Type = new String[0];
        try {
            List<String> allLines = Files.readAllLines(Paths.get(filePath));
            for (String line : allLines) {

                if (line.contains("@Test") && !line.contains("@TestInfo")) {
                    String[] arrOfStr2 = line.replace("@Test(", "").replace(")", "").split(",");
                    for (String desc : arrOfStr2) {
                        if (desc.contains("description")) {
                            String[] arrOfStr3 = desc.split("=");
                            AllScenerioTag.add(arrOfStr3[1].trim().replace("\"", ""));
                        }

                    }
                    if (line.replace(" ", "").contains("enabled=true")) {
                        String[] arrOfStr = line.replace("@Test(", "").replace(")", "").split(",");
                        for (String desc : arrOfStr) {
                            if (desc.contains("description")) {
                                String[] arrOfStr1 = desc.split("=");
                                //  System.out.println("Executed Scenerios :"+arrOfStr1[1].trim().replace("\"",""));
                                ExecutedScenerio.add(arrOfStr1[1].trim().replace("\"", ""));
                            }

                        }
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        int count = 0;
        int nooftag=0;
        for (int l = 0; l < ExecutedScenerio.size(); l++) {
            String ShortOrderType = ExecutedScenerio.get(l).substring(0, matchingIndexPattern);

            for (int J = 0; J < AllScenerioTag.size(); J++) {
                if (AllScenerioTag.get(J).contains(ShortOrderType)) {
                    count=count+1;

                } else {

                }
            }
            int tagcount = Regression_Count % count;

            if(tagcount==0)
            {
                tagcount=count;
            }
            for (int J = 0; J < AllScenerioTag.size(); J++) {
                if (AllScenerioTag.get(J).contains(ShortOrderType)) {
                    nooftag=nooftag+1;

                    if (nooftag==tagcount) {
                        System.out.println(nooftag);
                        if (!FinalTestToExecuteDuplicate.contains(AllScenerioTag.get(J).trim())) {
                            FinalTestToExecuteDuplicate.add(AllScenerioTag.get(J).trim());
                            FinalTestToExecute.add(nooftag+"#"+ AllScenerioTag.get(J).trim());
                            break;
                        }
                  else {
                      if(count>nooftag) {
                          int tegextended = nooftag+1;
                          FinalTestToExecute.add( tegextended +"#" + AllScenerioTag.get(J + 1).trim());
                      }
                  }
                    }
                }
            }
            count=0;
            nooftag=0;
        }

        System.out.println("Executed "+ ExecutedScenerio);
        System.out.println("All "+ AllScenerioTag);
        System.out.println("Final "+ FinalTestToExecute);


        for (int k = 0; k < ExecutedScenerio.size(); k++) {
            modifyFile1(filePath, ExecutedScenerio.get(k),"true", "false");
        }

        for (int k=0;k<FinalTestToExecute.size();k++)
        {
            String[] fin= FinalTestToExecute.get(k).split("#");
            int noofTag =Integer.parseInt(fin[0]);
            String FinalTesttoExecute =fin[1];
//            System.out.println(FinalTesttoExecute);
            String ShortOrderType1 = FinalTesttoExecute.substring(0, matchingIndexPattern);

            modifyFile2(filePath, FinalTesttoExecute,"false", "true",  ShortOrderType1, noofTag);
        }
    }


    public static void modifyFile1(String filePath, String ScenerioName, String oldString, String newString) {
        File fileToBeModified = new File(filePath);

        String oldContent = "";

        BufferedReader reader = null;

        FileWriter writer = null;

        try {
            reader = new BufferedReader(new FileReader(fileToBeModified));
            //Reading all the lines of input text file into oldContent

            String line = reader.readLine();

            while (line != null) {
                if(line.contains(ScenerioName))
                {
                    oldContent= oldContent + line.replace(oldString, newString) + System.lineSeparator();
                }
                else {
                    oldContent = oldContent + line + System.lineSeparator();
                }
                line = reader.readLine();

            }

            //Replacing oldString with newString in the oldContent
            String newContent = oldContent;

            //Rewriting the input text file with newContent

            writer = new FileWriter(fileToBeModified);

            writer.write(newContent);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                //Closing the resources

                reader.close();

                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void modifyFile2(String filePath,String ScenerioName, String oldString, String newString,String Matchtag, int Tagno) {
        File fileToBeModified = new File(filePath);

        String oldContent = "";

        BufferedReader reader = null;

        FileWriter writer = null;
        int count=0;
        try {
            reader = new BufferedReader(new FileReader(fileToBeModified));

            //Reading all the lines of input text file into oldContent

            String line = reader.readLine();

            while (line != null) {



                    if (line.contains("@Test")&&line.contains(Matchtag) && !line.contains("@TestInfo")) {
                        count = count + 1;
//                        System.out.println(Matchtag);
//                        System.out.println(count);
//                        System.out.println(Tagno);

                        if (count == Tagno) {
                            oldContent = oldContent + line.replace(oldString, newString) + System.lineSeparator();
//                            System.out.println(line);

                        } else {
                            oldContent = oldContent + line + System.lineSeparator();
                        }

                    }
                    else {
                        oldContent = oldContent + line + System.lineSeparator();
                    }


                line = reader.readLine();
            }
            //Replacing oldString with newString in the oldContent
            String newContent = oldContent;
            //Rewriting the input text file with newContent
            writer = new FileWriter(fileToBeModified);

            writer.write(newContent);
            count=0;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                //Closing the resources

                reader.close();

                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public static void updateproprtywithvalue(String key,String value) throws IOException {
        FileInputStream in = new FileInputStream("config.properties");
        Properties props = new Properties();
        props.load(in);
        in.close();

        FileOutputStream out = new FileOutputStream("config.properties");
        props.setProperty(key, value);
        props.store(out, null);
        out.close();
    }
    public static String readproperty(String key) throws IOException
    { String St=null;

        Properties pr= new Properties();
        InputStream file= new FileInputStream("config.properties");
        pr.load(file);
        St=pr.getProperty(key);
        file.close();
        return St;

    }
}