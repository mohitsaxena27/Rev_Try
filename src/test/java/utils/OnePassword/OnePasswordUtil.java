package utils.OnePassword;

import utils.PropertyReader;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.concurrent.ConcurrentHashMap;

public class OnePasswordUtil {
    // Cache to avoid multiple CLI calls (important for parallel execution)
    private static final ConcurrentHashMap<String, String> cache = new ConcurrentHashMap<>();
    public static String getSecret(String item, String field) throws IOException {
        // Vault name (keep centralized)
        PropertyReader propertyReader=new PropertyReader();
        String VAULT = propertyReader.readproperty("1PW_Vault");
        String key = item + "_" + field;

        // ✅ Step 1: Check cache
        if (cache.containsKey(key)) {
            return cache.get(key);
        }

        try {
            // ✅ Step 2: Build command
            ProcessBuilder pb = new ProcessBuilder(
                    "op.exe",
                    "item", "get", item,
                    "--vault", VAULT,
                    "--fields", "label=" + field,
                    "--reveal"
            );

            pb.redirectErrorStream(true);

            // ✅ Step 3: Execute process
            Process process = pb.start();

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(process.getInputStream())
            );

            StringBuilder output = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                output.append(line);
            }

            int exitCode = process.waitFor();

            // ✅ Step 4: Error handling
            if (exitCode != 0) {
                throw new RuntimeException("1Password CLI failed: " + output.toString());
            }

            String value = output.toString().trim();

            if (value.isEmpty()) {
                throw new RuntimeException("Empty value returned from 1Password");
            }

            // ✅ Step 5: Store in cache
            cache.put(key, value);

            return value;

        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch secret from 1Password", e);
        }
    }
}
