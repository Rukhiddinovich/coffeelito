import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeelito/data/local/db/local_database.dart';
import 'package:coffeelito/data/models/product/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsEvent>(_listenProducts);
    on<GetAllProductsEvent>(_getAllProducts);
    on<AddProductEvent>(_addProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<DeleteAllProductsEvent>(_deleteAllProduct);
    on<DecrementProductEvent>(_decrementProduct);
    on<IncrementProductEvent>(_incrementProduct);
    on<CheckProductEvent>(_checkProduct);
    on<ChangeCateIdProductsEvent>(changeCategoryId);
    on<UpdateEvent>(update);
  }

  List<CoffeeModelSql> productsSql=[];
  String searchText='';
  List<CoffeeModel> products=[];
  String categoryId = "";

  changeCategoryId(ChangeCateIdProductsEvent event, Emitter<ProductState> emit){
    categoryId=event.cateId;
    emit(ProductUpdateState());
    emit(ProductInitial());
  }

  update(UpdateEvent event, Emitter<ProductState> emit){
    emit(ProductUpdateState());
    emit(ProductInitial());
  }

  _addProduct(AddProductEvent event,Emitter<ProductState> emit)async{
    try{
      emit(ProductLoadingState());
      await LocalDatabase.insertProduct(event.productModelForSql);
      emit(ProductUpdateState());
    }catch(e){
      emit(ProductErrorState(errorText: e.toString()));
    }
    emit(ProductInitial());
  }

  _deleteProduct(DeleteProductEvent event,Emitter<ProductState> emit)async{
    try{
      emit(ProductLoadingState());
      await LocalDatabase.deleteProduct(event.id);
      emit(ProductUpdateState());
    }catch(e){
      emit(ProductErrorState(errorText: e.toString()));
    }
    emit(ProductInitial());
  }

  _decrementProduct(DecrementProductEvent event,Emitter<ProductState> emit)async{
    try{
      emit(ProductLoadingState());
      await LocalDatabase.decrementProduct(id: event.id);
      emit(ProductUpdateState());
    }catch(e){
      emit(ProductErrorState(errorText: e.toString()));
    }
    emit(ProductInitial());
  }

 _incrementProduct(IncrementProductEvent event,Emitter<ProductState> emit)async{
    try{
      emit(ProductLoadingState());
      await LocalDatabase.decrementProduct(id: event.id);
      emit(ProductUpdateState());
    }catch(e){
      emit(ProductErrorState(errorText: e.toString()));
    }
    emit(ProductInitial());
  }

 _checkProduct(CheckProductEvent event,Emitter<ProductState> emit)async{
    try{
      emit(ProductLoadingState());
      await LocalDatabase.checkProduct(id: event.id);
      emit(ProductUpdateState());
    }catch(e){
      emit(ProductErrorState(errorText: e.toString()));
    }
    emit(ProductInitial());
  }

  _getAllProducts(GetAllProductsEvent event,Emitter<ProductState> emit)async{
    try{
      emit(ProductLoadingState());
      productsSql=await LocalDatabase.getAllProducts();
      emit(ProductUpdateState());
    }catch(e){
      emit(ProductErrorState(errorText: e.toString()));
    }
    emit(ProductInitial());
  }

 _deleteAllProduct(DeleteAllProductsEvent event,Emitter<ProductState> emit)async{
    try{
      emit(ProductLoadingState());
      await LocalDatabase.deleteAllProducts();
      emit(ProductUpdateState());
    }catch(e){
      emit(ProductErrorState(errorText: e.toString()));
    }
    emit(ProductInitial());
  }

  Stream<List<CoffeeModel>> getProducts() async* {
    if (categoryId.isEmpty) {
      yield* FirebaseFirestore.instance.collection("products").snapshots().map(
            (event1) => event1.docs
            .map((doc) => CoffeeModel.fromJson(doc.data()))
            .toList(),
      );
    } else {
      yield* FirebaseFirestore.instance
          .collection("products")
          .where("categoryId", isEqualTo:categoryId)
          .snapshots()
          .map(
            (event1) => event1.docs
            .map((doc) => CoffeeModel.fromJson(doc.data()))
            .toList(),
      );
    }
  }

  _listenProducts(GetProductsEvent event, Emitter<ProductState> emit)async{
    emit(ProductLoadingState());
    getProducts().listen((List<CoffeeModel> product) {
      products = product;
      debugPrint("CURRENT USER ORDERS LENGTH:${products.length}");
    });
    emit(ProductUpdateState());
  }
}
