**Test**

- The following output shows that the module passes the unit tests

**SV Files**

- This is a 4 bit linear shift feedback register
- The primitive polynomial is 1 + X^3 + X^4

![lsfr](image.png)

- the verify file is as such
![verify](image-1.png)

- The passed messages for the follwing unit tests (using GTest)

![testbench](image-3.png)
![testbench2](image-4.png)
![testbench3](image-5.png)

![pass4](image-2.png)

- Which allows to unit test the register to make sure it outputs the correct sequence

- The same thing applies for the 7 bit LFSR with primitive polynomial = 1 + X^3 + X^7 

![lfsr7](image-6.png)

- This is how both tests are passed for the following tests

![testbench](image-7.png)
![testbench2](image-8.png)
![testbench3](image-9.png)

- The passing message:

![pass7](image-10.png)