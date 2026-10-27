package utils.Image;
import org.apache.pdfbox.cos.COSName;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDResources;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.testng.Assert;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;

public class PdfLogoValidator {

    /**
     * Compare two images using normalized pixel similarity.
     *
     * @param expectedImage expected/reference image
     * @param actualImage   image extracted from PDF
     * @return similarity between 0.0 and 1.0
     */
    public static double compareImages(
            BufferedImage expectedImage,
            BufferedImage actualImage) {

        if (expectedImage == null || actualImage == null) {
            return 0.0;
        }

        /*
         * Resize actual image to expected image dimensions.
         */
        BufferedImage resizedActual = resizeImage(
                actualImage,
                expectedImage.getWidth(),
                expectedImage.getHeight()
        );

        /*
         * Convert both images to RGB.
         *
         * This handles:
         * - PNG transparency
         * - ARGB images
         * - PDF images with different color models
         */
        BufferedImage expectedRGB =
                convertToRGB(expectedImage);

        BufferedImage actualRGB =
                convertToRGB(resizedActual);

        long totalPixels =
                (long) expectedRGB.getWidth()
                        * expectedRGB.getHeight();

        long matchingPixels = 0;

        /*
         * Maximum allowed RGB difference per pixel.
         *
         * A small difference is allowed because PDF generation
         * can slightly change image encoding/compression.
         */
        final int pixelTolerance = 20;

        for (int y = 0; y < expectedRGB.getHeight(); y++) {

            for (int x = 0; x < expectedRGB.getWidth(); x++) {

                int expectedPixel =
                        expectedRGB.getRGB(x, y);

                int actualPixel =
                        actualRGB.getRGB(x, y);

                int expectedR =
                        (expectedPixel >> 16) & 0xFF;

                int expectedG =
                        (expectedPixel >> 8) & 0xFF;

                int expectedB =
                        expectedPixel & 0xFF;

                int actualR =
                        (actualPixel >> 16) & 0xFF;

                int actualG =
                        (actualPixel >> 8) & 0xFF;

                int actualB =
                        actualPixel & 0xFF;

                int difference =
                        Math.abs(expectedR - actualR)
                                + Math.abs(expectedG - actualG)
                                + Math.abs(expectedB - actualB);

                /*
                 * Maximum total RGB difference is 765.
                 *
                 * pixelTolerance = 20 means the pixels must be
                 * very similar.
                 */
                if (difference <= pixelTolerance) {
                    matchingPixels++;
                }
            }
        }

        return (double) matchingPixels / totalPixels;
    }


    /**
     * Resize image to the required dimensions.
     */
    private static BufferedImage resizeImage(
            BufferedImage original,
            int width,
            int height) {

        BufferedImage resized =
                new BufferedImage(
                        width,
                        height,
                        BufferedImage.TYPE_INT_ARGB
                );

        Graphics2D graphics =
                resized.createGraphics();

        graphics.setRenderingHint(
                RenderingHints.KEY_INTERPOLATION,
                RenderingHints.VALUE_INTERPOLATION_BILINEAR
        );

        graphics.setRenderingHint(
                RenderingHints.KEY_RENDERING,
                RenderingHints.VALUE_RENDER_QUALITY
        );

        graphics.setRenderingHint(
                RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON
        );

        graphics.drawImage(
                original,
                0,
                0,
                width,
                height,
                null
        );

        graphics.dispose();

        return resized;
    }


    /**
     * Convert image to RGB while handling transparency.
     *
     * Transparent pixels are rendered against a white background.
     */
    private static BufferedImage convertToRGB(
            BufferedImage image) {

        BufferedImage rgbImage =
                new BufferedImage(
                        image.getWidth(),
                        image.getHeight(),
                        BufferedImage.TYPE_INT_RGB
                );

        Graphics2D graphics =
                rgbImage.createGraphics();

        /*
         * White background for transparent pixels.
         */
        graphics.setColor(Color.WHITE);

        graphics.fillRect(
                0,
                0,
                image.getWidth(),
                image.getHeight()
        );

        graphics.drawImage(
                image,
                0,
                0,
                null
        );

        graphics.dispose();

        return rgbImage;
    }
}