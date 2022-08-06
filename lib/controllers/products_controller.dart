import 'package:bazaar_adm/models/product.dart';
import 'package:bazaar_adm/models/products_batch.dart';
import 'package:bazaar_adm/services/product_service.dart';
import 'package:get/state_manager.dart';

class ProductsController extends GetxController {
  
  final RxList<Product> products = <Product>[].obs;
  final ProductService _productService = ProductService();
  RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    findAllProducts();
  }

  void createProduct(String name, String brand, String category, String? description, ProductsBatch? productsBatch) async {
    isLoading(true);
    Product product = Product(name: name, brand: brand, category: category, description: description, productsBatch: productsBatch);    
    Product createdProduct = await _productService.createProduct(product);
    products.add(createdProduct);
    isLoading(false);
  }

  void findAllProducts() async {
    isLoading(true);
    products.value = List.from(await _productService.findAllProducts());
    isLoading(false);
  }

  void updateProduct(Product product, int productIndex) async {
    isLoading(true);
    await _productService.updateProduct(product);
    products[productIndex] = product;
    isLoading(false);
  }

  void deleteProduct(int? productId, int productIndex) async {
    isLoading(true);
    if(productId != null) {
      await _productService.deleteProduct(productId);
      products.removeAt(productIndex);
    }
    isLoading(false);
  }

}