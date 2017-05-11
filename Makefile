GROUP_PATH=eic
GROUP_NAME=eic
ARTIFACT_ID=jnimathlib
ARTIFACT_VERSION=0.1
JAR=$(ARTIFACT_ID)-$(ARTIFACT_VERSION).jar

CLASS_NAME=CMath
JAVA_SOURCE=$(GROUP_PATH)/$(ARTIFACT_ID)/$(CLASS_NAME).java
JAVA_CLASS=$(GROUP_PATH)/$(ARTIFACT_ID)/$(CLASS_NAME).class

C_HDR=src/$(CLASS_NAME).javah.h
C_SRC=src/$(CLASS_NAME).c
JNI_LIB=lib/lib$(CLASS_NAME).so

.PHONY: all clean benchmark

all: $(JNI_LIB) $(JAR)

clean:
	rm -f $(JNI_LIB) $(C_HDR) $(JAVA_CLASS) $(JAR)

benchmark: export LD_LIBRARY_PATH=$(PWD)/lib
benchmark: $(JNI_LIB) $(JAR)
	java -cp $(JAR) $(GROUP_NAME).$(ARTIFACT_ID).$(CLASS_NAME) 20000000

JAVA_PATH ?= /usr/lib/jvm/default
JNI_INCLUDE=-I$(JAVA_PATH)/include -I$(JAVA_PATH)/include/linux

$(JNI_LIB): $(C_SRC) $(C_HDR)
	$(CXX) -o $@ $(CPPFLAGS) $(CFLAGS) $(JNI_INCLUDE) -shared -fPIC $<

$(C_HDR): $(JAVA_CLASS)
	javah -force -o $@ $(GROUP_NAME).$(ARTIFACT_ID).$(CLASS_NAME)

$(JAVA_CLASS): $(JAVA_SOURCE)
	javac $<

$(JAR): $(JAVA_CLASS) $(JNI_LIB)
	jar cf $@ $^
