#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ ${JAVA_HOME+1} ]]; then
  JAVA="${JAVA_HOME}/bin/java"
else
  echo "JAVA_HOME undefined, using java from path. For control over exact java version, set JAVA_HOME"
  JAVA="java"
fi;

# -Xmx1024m             use up to 1GB RAM (edit to increase)
# -Dfile.encoding=UTF-8 ensure Unicode characters in model files are compatible cross-platform
JVM_OPTS=(-Xmx1024m -Dfile.encoding=UTF-8)
OPTS_INDEX=2

ARGS=()
INDEX=0

for arg in "$@"; do
  if [[ "$arg" == "--3D" ]]; then
    JVM_OPTS[OPTS_INDEX++]="-Dorg.nlogo.is3d=true"
  elif [[ "$arg" == -D* ]]; then
    JVM_OPTS[OPTS_INDEX++]="$arg"
  else
    ARGS[INDEX++]="$arg"
  fi
done

RAW_CLASSPATH="Java/args4j-2.0.12.jar:Java/asm-all-5.0.4.jar:Java/asm-all-5.0.4.jar:Java/asm-all-5.0.4.jar:Java/autolink-0.6.0.jar:Java/autolink-0.6.0.jar:Java/behaviorsearch.jar:Java/commons-codec-1.10.jar:Java/commons-codec-1.10.jar:Java/commons-logging-1.1.1.jar:Java/commons-logging-1.1.1.jar:Java/config-1.3.1.jar:Java/config-1.3.1.jar:Java/flexmark-0.20.0.jar:Java/flexmark-0.20.0.jar:Java/flexmark-ext-autolink-0.20.0.jar:Java/flexmark-ext-autolink-0.20.0.jar:Java/flexmark-ext-escaped-character-0.20.0.jar:Java/flexmark-ext-escaped-character-0.20.0.jar:Java/flexmark-ext-typographic-0.20.0.jar:Java/flexmark-ext-typographic-0.20.0.jar:Java/flexmark-formatter-0.20.0.jar:Java/flexmark-formatter-0.20.0.jar:Java/flexmark-util-0.20.0.jar:Java/flexmark-util-0.20.0.jar:Java/gluegen-rt-2.3.2.jar:Java/gluegen-rt-2.3.2.jar:Java/httpclient-4.2.jar:Java/httpclient-4.2.jar:Java/httpcore-4.2.jar:Java/httpcore-4.2.jar:Java/httpmime-4.2.jar:Java/httpmime-4.2.jar:Java/java-objc-bridge-1.0.0.jar:Java/jcommon-1.0.16.jar:Java/jfreechart-1.0.13.jar:Java/jhotdraw-6.0b1.jar:Java/jhotdraw-6.0b1.jar:Java/jmf-2.1.1e.jar:Java/jmf-2.1.1e.jar:Java/jna-4.2.2.jar:Java/jogl-all-2.3.2.jar:Java/jogl-all-2.3.2.jar:Java/json-simple-1.1.1.jar:Java/json-simple-1.1.1.jar:Java/log4j-1.2.16.jar:Java/log4j-1.2.16.jar:Java/macro-compat_2.12-1.1.1.jar:Java/macro-compat_2.12-1.1.1.jar:Java/macro-compat_2.12-1.1.1.jar:Java/netlogo-6.0.2.jar:Java/netlogo-6.0.2.jar:Java/netlogo-mac-app.jar:Java/parboiled_2.12-2.1.3.jar:Java/parboiled_2.12-2.1.3.jar:Java/parboiled_2.12-2.1.3.jar:Java/picocontainer-2.13.6.jar:Java/picocontainer-2.13.6.jar:Java/picocontainer-2.13.6.jar:Java/rsyntaxtextarea-2.6.0.jar:Java/rsyntaxtextarea-2.6.0.jar:Java/scala-library-2.12.2.jar:Java/scala-library-2.12.2.jar:Java/scala-parser-combinators_2.12-1.0.5.jar:Java/scala-parser-combinators_2.12-1.0.5.jar:Java/shapeless_2.12-2.3.2.jar:Java/shapeless_2.12-2.3.2.jar:Java/shapeless_2.12-2.3.2.jar"
CLASSPATH=''

for jar in `echo $RAW_CLASSPATH | sed 's/:/ /g'`; do
  CLASSPATH="$CLASSPATH:$BASE_DIR/$jar"
done

CLASSPATH=`echo $CLASSPATH | sed 's/://'`

# -classpath ....         specify jars
# org.nlogo.headless.Main specify we want headless, not GUI
# "${ARGS[0]}"            pass along any additional arguments
java "${JVM_OPTS[@]}" -Dnetlogo.extensions.dir="${BASE_DIR}/extensions" -classpath "$CLASSPATH" org.nlogo.headless.Main "${ARGS[@]}"