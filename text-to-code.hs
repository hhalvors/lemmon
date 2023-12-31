import System.IO
import System.FilePath
import Text.Regex.TDFA

-- Assuming EatProofLine is defined somewhere in your code
eatProofLine :: String -> String  -- Replace with the actual type signature

processFile :: FilePath -> IO ()
processFile filePath = do
    content <- readFile filePath
    let lines = filter (\line -> line =~ pattern :: Bool) $ lines content
    case lines of
        (line:_) -> do
            let result = eatProofLine line
            let outputFilePath = dropExtension filePath ++ "-codec.hs"
            writeFile outputFilePath result
        _ -> putStrLn "No matching line found in the file."
  where
    pattern = "^[0-9]+(,[0-9]+)* \\([0-9]+\\)"
