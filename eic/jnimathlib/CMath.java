package eic.jnimathlib;

public class CMath
{
    public static native double acos(double value);

    static 
    {
        System.loadLibrary("CMath");
    }
    
    public static void main(String[] args) 
    {
        double d;
	int nIters = Integer.parseInt(args[0]);
	long startTime = 0;
	long stopTime = 0;

	System.out.println();

        System.out.println("Native acos() benchmark started...");
	startTime = System.nanoTime();
        for (int i=0; i < nIters; i++)
        {
            d = (i / 3.1415926) % 2 - 1;
            d = CMath.acos(d);
        }
	stopTime = System.nanoTime();
	double nativeDiffTime = stopTime - startTime;
        System.out.println("Native acos() benchmark done. Elapsed time is " + nativeDiffTime / 1000000000. + " seconds");

        System.out.println("Java acos() benchmark started...");
	startTime = System.nanoTime();
        for (int i=0; i < nIters; i++)
        {
            d = (i / 3.1415926) % 2 - 1;
            d = java.lang.Math.acos(d);
        }
	stopTime = System.nanoTime();
	double javaDiffTime = stopTime - startTime;
        System.out.println("Java acos() benchmark done. Elapsed time is " + javaDiffTime / 1000000000. + " seconds");

	System.out.println();

        System.out.println("acos(): Fractional CPU time savings with JNI library is " + (1 - nativeDiffTime / javaDiffTime) * 100. + " percent");
    }
}
