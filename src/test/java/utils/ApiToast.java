package utils;

public class ApiToast {
    public String requestBody;
    public String url;
    public String response;

    public String toString() {
        return "Request: " + requestBody + "\nURL: " + url + "\nResponse: " + response;
    }

}