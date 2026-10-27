package utils;

import java.awt.*;
import java.util.HashMap;
import java.util.Map;

public class ColorUtils{
    // CSS/X11 Named Colors (subset shown, expand as needed)
    private static final Map<String, Color> COLOR_MAP = new HashMap<>();
    static {
        COLOR_MAP.put("Black", new Color(0, 0, 0));
        COLOR_MAP.put("White", new Color(255, 255, 255));
        COLOR_MAP.put("Red", new Color(255, 0, 0));
        COLOR_MAP.put("Dark Red", new Color(255, 83, 138));
        COLOR_MAP.put("Lime", new Color(0, 255, 0));
        COLOR_MAP.put("Blue", new Color(0, 0, 255));
        COLOR_MAP.put("SteelBlue", new Color(33, 95, 151));
        COLOR_MAP.put("Yellow", new Color(255, 255, 0));
        COLOR_MAP.put("Gray", new Color(128, 128, 128));
        COLOR_MAP.put("Silver", new Color(192, 192, 192));
        COLOR_MAP.put("Gold", new Color(255, 215, 0));
        COLOR_MAP.put("GoldenRod", new Color(218, 165, 32));
        COLOR_MAP.put("Khaki", new Color(240, 230, 140));
        COLOR_MAP.put("Tan", new Color(210, 180, 140));
        COLOR_MAP.put("Wheat", new Color(245, 222, 179));
        COLOR_MAP.put("Earth Yellow", new Color(225, 190, 92)); // your case
        COLOR_MAP.put("LightGray", new Color(201, 201, 201)); // your case
        COLOR_MAP.put("Green", new Color(59, 167, 85)); // your case
        COLOR_MAP.put("BrightBlue", new Color(27, 150, 255)); // your case
        COLOR_MAP.put("Orange", new Color(242, 139, 0)); // your case
        COLOR_MAP.put("Teal", new Color(6, 165, 154)); // your case
        COLOR_MAP.put("Light Grey", new Color(147, 147, 147)); // your case
        COLOR_MAP.put("Purple", new Color(47, 44, 183)); // your case
    }

    // Find nearest color name
    public static String getClosestColorName(int r, int g, int b) {
        Color inputColor = new Color(r, g, b);
        String closestColorName = null;
        double minDistance = Double.MAX_VALUE;

        for (Map.Entry<String, Color> entry : COLOR_MAP.entrySet()) {
            double distance = colorDistance(inputColor, entry.getValue());
            if (distance < minDistance) {
                minDistance = distance;
                closestColorName = entry.getKey();
            }
        }
        return closestColorName != null ? closestColorName : "Unknown";
    }

    private static double colorDistance(Color c1, Color c2) {
        int rDiff = c1.getRed() - c2.getRed();
        int gDiff = c1.getGreen() - c2.getGreen();
        int bDiff = c1.getBlue() - c2.getBlue();
        return Math.sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff);
    }
}
