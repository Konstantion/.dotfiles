import java.io.*;
import java.nio.file.*;
import java.util.*;

public class ImportantFileManager {

    private static final String IMPORTANT_FILE = String.join(
            File.separator,
            System.getProperty("user.home"),
            ".important");

    private static Set<String> importantFiles = new HashSet<>();

    public static void main(String[] args) throws IOException {
        loadImportantFiles();

        if (args.length < 1) {
            System.out.println("Usage: important [mark|unmark|find]");
            return;
        }

        String command = args[0];
        final String filePath;

        switch (command) {
            case "mark":
                filePath = args[1];
                markFile(filePath);
                break;
            case "unmark":
                filePath = args[1];
                unmarkFile(filePath);
                break;
            case "find":
                findFiles(args);
                break;
            default:
                System.out.println("Invalid command. Use 'mark' or 'unmark'.");
        }

        saveImportantFiles();
    }

    private static void findFiles(String[] args) {
        String directory = System.getProperty("user.dir");
        String extension = "";
        String namePart = "";

        for (int i = 1; i < args.length; i++) {
            if (args[i].equals("--dir") && i + 1 < args.length) {
                directory = args[++i];
            } else if (args[i].equals("--ext") && i + 1 < args.length) {
                extension = args[++i];
            } else if (args[i].equals("--name-contains") && i + 1 < args.length) {
                namePart = args[++i];
            }
        }

        try {
            final String finalExtension = extension;
            final String finalNamePart = namePart;

            Files.walk(Paths.get(directory))
                    .filter(Files::isRegularFile)
                    .filter(path -> path.toString().endsWith(finalExtension))
                    .filter(path -> path.getFileName().toString().contains(finalNamePart))
                    .map(Path::toAbsolutePath)
                    .filter(path -> importantFiles.contains(path.toString()))
                    .forEach(System.out::println);
        } catch (IOException e) {
            System.out.println("Error searching files: " + e.getMessage());
        }
    }

    private static void loadImportantFiles() throws IOException {
        try {
            Path path = Paths.get(IMPORTANT_FILE).toAbsolutePath().normalize();

            if (Files.exists(path)) {
                List<String> lines = Files.readAllLines(path);
                importantFiles.addAll(lines);
                // System.out.println("Loaded important files: " + importantFiles.size());
            } else {
                System.out.println("No important files found.");
            }
        } catch (InvalidPathException e) {
            System.out.println("Invalid file path: " + IMPORTANT_FILE);
        }
    }

    private static void saveImportantFiles() throws IOException {
        Path path = Paths.get(IMPORTANT_FILE).toAbsolutePath().normalize();
        Files.write(path, importantFiles);
        // System.out.println("Saved important files: " + importantFiles.size());
    }

    private static void markFile(String filePath) {
        try {
            Path path = Paths.get(filePath).toAbsolutePath().normalize();
            if (Files.exists(path)) {
                importantFiles.add(path.toString());
                System.out.println("Marked file as important: " + path);
            } else {
                System.out.println("File does not exist: " + path);
            }
        } catch (InvalidPathException e) {
            System.out.println("Invalid file path: " + filePath);
        }
    }

    private static void unmarkFile(String filePath) {
        try {
            Path path = Paths.get(filePath).toAbsolutePath().normalize();
            if (Files.exists(path) && importantFiles.remove(path.toString())) {
                System.out.println("Unmarked file as important: " + path);
            } else {
                System.out.println("File is not marked as important or does not exist: " + path);
            }
        } catch (InvalidPathException e) {
            System.out.println("Invalid file path: " + filePath);
        }
    }
}
