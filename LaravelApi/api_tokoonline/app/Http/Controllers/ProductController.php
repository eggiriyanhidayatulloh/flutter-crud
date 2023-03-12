<?php

namespace App\Http\Controllers;


use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function index() {
        $products = Product::all();
        return view('products.index',compact(['products']));
    }

    public function create() 
    {
        return view('products.create');
    }

    public function store(Request $request)
    {
        // dd($request->all());
        // untuk menyimpan semua inputan ke database
        Product::create($request->all());
        // setelah menyimpan akan langsung ke path products
        return redirect('/products');
    }
    
    public function edit($id)
    {   
        // untuk mengambil product berdasarkan id nya
        $product = Product::find($id);
        return view('products.edit',compact(['product']));
    }

    public function update(Request $request,$id)
    {   
        $product = Product::find($id);
        // menyimpan data yang sudah di update
        $product->update($request->all());
        return redirect('/products');
    }

    public function destroy($id)
    {   
        $product = Product::find($id);
        $product->delete();
        return redirect('/products');
    }
}