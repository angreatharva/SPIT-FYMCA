import java.util.HashMap;

public class GameSettings {
    private static HashMap<String, Object> settings = new HashMap<>();

    static {
        initialize();
    }

    public static void initialize() {
        settings.put("difficulty", "medium");
        settings.put("ghostSpeed", 1);
        settings.put("pelletPoints", 10);
        settings.put("usePathfinding", true);
        settings.put("ghostUpdateInterval", 10);
    }

    public static Object getSetting(String key) {
        return settings.getOrDefault(key, null);
    }

    public static void setSetting(String key, Object value) {
        settings.put(key, value);
    }
}