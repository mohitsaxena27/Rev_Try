package utils;

import net.sourceforge.tess4j.ITesseract;
import net.sourceforge.tess4j.Tesseract;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;
import java.io.ByteArrayInputStream;
import java.util.Arrays;

public class OCRUtil {

    private static final ITesseract tesseract;

    static {
        tesseract = new Tesseract();
        tesseract.setDatapath(String.format("%s/tessdata", System.getProperty("user.dir")));
        tesseract.setLanguage("eng");
    }


    public static String getTextFromImage(String base64) {
        try {
            byte[] imageBytes = DatatypeConverter.parseBase64Binary(base64);
            return tesseract.doOCR(ImageIO.read(new ByteArrayInputStream(imageBytes))).replaceAll("\\nB\\n", "").replace("/", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }


    public static double[][] createRectangle(
            double centerLat,
            double centerLon,
            double widthMeters,
            double heightMeters) {

        double earthRadius = 6378137.0;

        // Half dimensions
        double halfWidth = widthMeters / 2.0;
        double halfHeight = heightMeters / 2.0;

        // Latitude change
        double latOffset = Math.toDegrees(halfHeight / earthRadius);

        // Longitude change depends on latitude
        double lonOffset = Math.toDegrees(
                halfWidth / (earthRadius * Math.cos(Math.toRadians(centerLat)))
        );

        double topLat = centerLat + latOffset;
        double bottomLat = centerLat - latOffset;
        double leftLon = centerLon - lonOffset;
        double rightLon = centerLon + lonOffset;

        return new double[][] {
                {topLat, rightLon},       // Top-Right
                {topLat, leftLon},        // Top-Left
                {bottomLat, leftLon},     // Bottom-Left
                {bottomLat, rightLon}     // Bottom-Right
        };
    }

    public static void main(String[] args){
        double[][] corners = createRectangle(
                41.8820,
                -87.6331,
                80,  // width in meters
                150   // height in meters
        );
        System.out.println("Top-Right:    " + Arrays.toString(corners[0]));
        System.out.println("Top-Left:     " + Arrays.toString(corners[1]));
        System.out.println("Bottom-Left:  " + Arrays.toString(corners[2]));
        System.out.println("Bottom-Right: " + Arrays.toString(corners[3]));
    }
}
