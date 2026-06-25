class Product {
    int productId;
    String productName;
    String category;

    Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }
}

class SearchAlgorithms {
    public static Product linearSearch(Product[] products, int targetId) {
        for(int i = 0; i < products.length; i++) {
            if(products[i].productId == targetId) {
                return products[i];
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, int targetId) {
        int left = 0;
        int right = products.length - 1;

        while(left <= right) {
            int mid = (left + right) / 2;

            if(products[mid].productId == targetId) {
                return products[mid];
            } else if(products[mid].productId < targetId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }
}

public class ecommerce
 {
    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Laptop", "Electronics"),
            new Product(2, "Shoes", "Footwear"),
            new Product(3, "Phone", "Electronics"),
            new Product(4, "Shirt", "Clothing"),
            new Product(5, "Watch", "Accessories")
        };

        // Linear Search
        System.out.println("--- Linear Search ---");
        Product result1 = SearchAlgorithms.linearSearch(products, 3);
        if(result1 != null) {
            System.out.println("Found: " + result1.productName + " | Category: " + result1.category);
        } else {
            System.out.println("Product not found");
        }

        // Binary Search (array must be sorted by productId)
        System.out.println("--- Binary Search ---");
        Product result2 = SearchAlgorithms.binarySearch(products, 3);
        if(result2 != null) {
            System.out.println("Found: " + result2.productName + " | Category: " + result2.category);
        } else {
            System.out.println("Product not found");
        }
    }
}