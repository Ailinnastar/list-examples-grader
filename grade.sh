CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir student-submission
mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if ! [ -f student-submission/ListExamples.java ]
then 
    echo "Missing Necessary File"
    exit 1
fi
pwd
echo "continue"

cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area

cd grading-area
pwd


javac -cp $CPATH *.java
if [ $? -ne 0 ]
then 
    echo 'compiler error'
    exit 1
fi



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
