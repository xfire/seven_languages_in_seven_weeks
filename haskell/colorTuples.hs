colors = ["black", "white", "blue", "yellow", "red"]

colorTuples :: [(String, String)]
colorTuples = [(a, b) | a <- colors, b <- colors, a < b]
