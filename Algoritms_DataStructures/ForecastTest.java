public class ForecastTest {

    public static double futureValue(double startingAmount, double growthRate, int year) {
        if(year == 0) {
            return startingAmount;
        }
        return futureValue(startingAmount, growthRate, year - 1) * (1 + growthRate);
    }

    public static void main(String[] args) {
        double startingAmount = 10000;
        double growthRate = 0.10;
        int years = 5;

        double result = futureValue(startingAmount, growthRate, years);

        System.out.println("Starting Amount: Rs." + startingAmount);
        System.out.println("Growth Rate: 10% per year");
        System.out.println("Years: " + years);
        System.out.println("Future Value after " + years + " years: Rs." + result);
    }
}