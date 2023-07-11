#!/bin/bash
# This is our first script.
echo 'Performing modify_examples script'

rm -rf Tests


mkdir Tests
mkdir Tests/Test1
cd Tests/Test1
touch aaaa.txt
touch bBbBb.txt
mkdir Test1_1
cd Test1_1
touch CcCcccC.bmp
touch dddddDDDD.txt

cd ..
cd ..
cd ..

test1(){
    echo
    echo
        echo "*********************************************"
    echo Test 1: no arguments
    bash ./modify.sh

    
    read -p "Did the error occur? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 1 passed"
    else
        echo "Test 1 failed"
        exit 1
    fi

    echo "*********************************************"
    sleep 2

}

test2(){
    echo    
    echo
        echo "*********************************************"
    echo test 2: -r as only parameter
    bash ./modify.sh -r Tests/Test1
   
    read -p "Did the error occur? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 2 passed"
    else
        echo "Test 2 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test3(){
    echo    
    echo
        echo "*********************************************"
    echo test 3: -l and -u at the same time
    bash ./modify.sh -l -u Tests/Test1
    
    read -p "Did the error occur? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 3 passed"
    else
        echo "Test 3 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test4(){
    echo    
    echo
    echo "*********************************************"   
    echo test 4: Perform modify.sh with -l and -r
    echo
    echo Before:
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..
    bash ./modify.sh -r -l Tests/Test1
    echo
    echo After:
    
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..

    
    read -p "Are the files changed correctly? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 4 passed"
    else
        echo "Test 4 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test5(){
    echo    
    echo
    echo "*********************************************"
    echo test 5: no path parameter
    bash ./modify.sh -l
   
    read -p "Did the error occur? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 5 passed"
    else
        echo "Test 5 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test6(){
    echo    
    echo
    echo "*********************************************"
    echo test 6: only path parameter
    bash ./modify.sh Tests/Test1
    read -p "Did the error occur? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 6 passed"
    else
        echo "Test 6 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test7(){
    echo    
    echo
    echo "*********************************************"
    echo test 7: trying to modify modify.sh
    cd Tests/Test1
    touch modify.sh
    cd ..
    cd ..
    bash ./modify.sh -u Tests/Test1
    read -p "Did the error occur? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 7 passed"
    else
        echo "Test 7 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test8(){
    echo    
    echo
    echo "*********************************************"   
    echo test 8: Perform modify.sh with -u and -r
    echo
    echo Before:
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..
    bash ./modify.sh -r -u Tests/Test1
    echo
    echo After:
    
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..

    
    read -p "Are the files changed correctly? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 8 passed"
    else
        echo "Test 8 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test9(){
    echo    
    echo
    echo "*********************************************"   
    echo test 9: Perform modify.sh with -l on Tests/Test1
    echo
    echo Before:
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..
    bash ./modify.sh -l Tests/Test1
    echo
    echo After:
    
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..

    
    read -p "Are the files changed correctly? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 8 passed"
    else
        echo "Test 8 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test10(){
    echo    
    echo
    echo "*********************************************"   
    echo test 10: Perform modify.sh with -u on Tests/Test1
    echo
    echo Before:
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..
    bash ./modify.sh -u Tests/Test1
    echo
    echo After:
    
    cd Tests/Test1
    ls
    ls Test1_1
    cd ..
    cd ..

    
    read -p "Are the files changed correctly? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 10 passed"
    else
        echo "Test 10 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test11(){
    echo    
    echo
    echo "*********************************************"
    echo test 11: show help
    bash ./modify.sh -h
    read -p "Is help shown? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 11 passed"
    else
        echo "Test 11 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test12(){
    echo    
    echo
    echo "*********************************************"
    echo test 12: -h and -u parameters
    bash ./modify.sh -h -u
    read -p "Is help shown? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 12 passed"
    else
        echo "Test 12 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test13(){
    echo    
    echo
    echo "*********************************************"
    echo "test 13: trying wrong parameters (-g)"
    bash ./modify.sh -g
    read -p "Is there an error? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 13 passed"
    else
        echo "Test 13 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test14(){
    echo    
    echo
    echo "*********************************************"
    echo "test 14: trying wrong and correct parameters (-r -g -u)"
    bash ./modify.sh -r -g -u
    read -p "Is there an error? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 14 passed"
    else
        echo "Test 14 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test15(){
    echo    
    echo
    echo "*********************************************"   
    echo test 15: Perform modify.sh with -u and -r on Tests/Test1- added hidden folder
    echo
    echo Before:
    cd Tests/Test1
    mkdir .hiddenFolder
    cd .hiddenFolder
    touch .hiddenFile.txt
    touch hHhhhHhhh.txt
    echo Tests/Test1/.hiddenFolder:
    ls -a
    cd ..
    echo Tests/Test1:
    ls -a
    echo Tests/Test1/Test1_1:
    ls Test1_1
    cd ..
    cd ..
    bash ./modify.sh -r -u Tests/Test1
    echo
    echo After:
    cd Tests/Test1
    cd .hiddenFolder
    echo Tests/Test1/.hiddenFolder:
    ls -a
    cd ..
    echo Tests/Test1:
    ls -a
    echo Tests/Test1/Test1_1:
    ls Test1_1
    cd ..
    cd ..

    
    read -p "Are the files changed correctly? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 15 passed"
    else
        echo "Test 15 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}

test16(){
    echo    
    echo
    echo "*********************************************"   
    echo "test 16: Perform modify.sh with -r `s/H/j/g` on Tests/Test1 - check sed option"
    echo
    echo Before:
    echo Tests/Test1/.hiddenFolder:
    cd Tests/Test1/.hiddenFolder
    ls -a
    cd ..
    echo Tests/Test1:
    ls -a
    echo Tests/Test1/Test1_1:
    ls Test1_1
    cd ..
    cd ..
    bash ./modify.sh -r 's/H/j/g' Tests/Test1
    echo
    echo After:
    
    cd Tests/Test1
    cd .hiddenFolder
    echo Tests/Test1/.hiddenFolder:
    ls -a
    cd ..
    echo Tests/Test1
    ls -a
    echo Tests/Test1/Test1_1
    ls Test1_1
    cd ..
    cd ..


    
    read -p "Are the files changed correctly? (y/n): " ans
    if [ "$ans" = "y" ]; then
        echo "Test 16 passed"
    else
        echo "Test 16 failed"
        exit 1
    fi
    echo "*********************************************"
    sleep 2
}
clear
test1;
clear
test2;
clear
test3;
clear
test4;
clear
test5;
clear
test6;
clear
test7;
clear
test8;
clear
test9;
clear
test10;
clear
test11;
clear
test12;
clear
test13;
clear
test14;
clear
test15;
clear
test16;