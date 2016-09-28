#	ANTLR4 must be set as an exported variable
#
#			export ANTLR4="/<PATH TO ANTLR JAR>/antlr-4.5-complete.jar"
#			export CLASSPATH="/<PATH TO ANTLR JAR>/antlr-4.5-complete.jar:$CLASSPATH"
#
## Comands:
# all:					Builds everything to make a runnable program
# run:					Runs The program builds if necessary
# clean: 				Cleans generated files
#
## Variables (DON'T TOUCH THESE. THEY WILL ONLY CHANGE ON YOUR COPY)
#	SRC:			The source folder
#	GEN:			The folder where generated antlr files will go
#	BIN:			The folder where the generated java class will go
#	JAR:			The name of the jar execuable will go
#	INTELLIJ:	Files from INTELLIJ
SRC=src
GEN=gen
BIN=bin
JAR=shopifycost.jar

INTELLIJ=out

all: $(JAR)

run: $(JAR)
ifeq "$f" ""
	@printf "Usage: make run f=\"<filename>\"\n"
else
	@java -cp "$(JAR):$(ANTLR4)" Main $f
endif

clean:
ifneq "$(wildcard $(GEN))" ""
	@printf "Removing Generated files...\t"
	@-rm -rf $(GEN)
	@printf "Done\n"
endif
ifneq "$(wildcard $(BIN))" ""
	@printf "Removing Class files...\t\t"
	@-rm -rf $(BIN)
	@printf "Done\n"
endif
ifneq "$(wildcard $(JAR))" ""
	@printf "Removing Jar file...\t\t"
	@-rm -rf $(JAR)
	@printf "Done\n"
endif
ifneq "$(wildcard $(INTELLIJ))" ""
	@printf "Removing Intellij generated...\t"
	@-rm -rf $(INTELLIJ)
	@printf "Done\n"
endif

$(GEN): $(SRC)/*.g4
	 @printf "Generating Antlr4 files..."
	 @java -cp "$(ANTLR4)" org.antlr.v4.Tool $(SRC)/*.g4 -o $(GEN)/ \
	 -listener -visitor
	 @mv $(GEN)/src/* $(GEN)/
	 @rmdir $(GEN)/src/
	 @touch $(GEN)
	 @printf "\tDone\n"

$(JAR): $(GEN) $(BIN)
	@printf "Building Jar file..."
	@jar cfe $(JAR) Main -C $(BIN)/ .
	@printf "\t\tDone\n"

$(BIN): $(GEN) $(SRC)/*.java
	@printf "Building class files..."
	@mkdir -p $(BIN)
	@javac -cp "$(ANTLR4)" -d "$(BIN)" $(GEN)/*.java $(SRC)/*.java
	@touch $(BIN)
	@printf "\t\tDone\n"