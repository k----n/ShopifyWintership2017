import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import java.io.InputStream;
import java.net.URL;

/**
 Main Class that takes url from stdin and outputs total cost of clocks and watches to stdout

 Copyright 2016 Terence Parr, Kalvin Eng

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 **/

public class Main {
    public static void main(String[] args) throws Exception {

        String inputFile = null;
        if (args.length > 0) inputFile = args[0];
        InputStream is = System.in;
        if (inputFile != null) {
            is = new URL(inputFile).openStream();
        }

        // create a CharStream that reads from standard input
        ANTLRInputStream input = new ANTLRInputStream(is);

        // create a lexer that feeds off of input CharStream
        ShopifyLexer lexer = new ShopifyLexer(input);

        // create a buffer of tokens pulled from the lexer
        CommonTokenStream tokens = new CommonTokenStream(lexer);

        // create a parser that feeds off the tokens buffer
        ShopifyParser parser = new ShopifyParser(tokens);

        ParseTree tree = parser.init(); // begin parsing at json rule

        ParseTreeWalker walker = new ParseTreeWalker();

        ShopifyListener listener = new Interpreter();

        walker.walk(listener, tree);
    }

}