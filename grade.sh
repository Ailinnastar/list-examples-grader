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



  passed=0
  failed=0
  for test_file in $original_dir/test-data/*.txt
  do
    result=`java Sorter < $test_file`
    expect=`cat $test_file.expect`
    if [[ $expect == $result ]]
    then
      passed=$(( $passed+1 ))
    else
      failed=$(( $failed+1 ))
    fi
  done
  echo "$submission_dir: Test results: $passed passed, $failed failed" > result.txt
  cd $original_dir
done

all_results=`find submissions -name "result.txt"`
cat $all_results | grep "Compile error"  > compile-errors.txt

cat $all_results | grep "passed" > run-results.txt
grep 'Test result' $all_results > run-results.txt
