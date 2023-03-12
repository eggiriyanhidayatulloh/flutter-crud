<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductApiController extends Controller
{
    
    public function index(){
        $products = Product::all();
        return response()->json(['message' => 'Success','data' => $products]);
    }

    public function show($id){
        $product = Product::find($id);
        return response()->json(['message' => 'Success','data' => $product]);
    }

    public function store(Request $request)
    {
        // dd($request->all());
        // untuk menyimpan semua inputan ke database
        $product = Product::create($request->all());
        // setelah menyimpan akan langsung ke path products
        return response()->json(['message' => 'Success','data' => $product]);
    }

    public function update(Request $request,$id)
    {   
        $product = Product::find($id);
        // menyimpan data yang sudah di update
        $product->update($request->all());
        return response()->json(['message' => 'Update Success','data' => $product]);
    }

    public function destroy($id)
    {   
        $product = Product::find($id);
        $product->delete();
        return response()->json(['message' => 'Delete Success','data' => null]);
    }
}
