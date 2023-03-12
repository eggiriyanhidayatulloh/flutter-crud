<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    // use HasFactory;
    // use SoftDeletes;

    // melindungi field id
    // guarded menyimpan field yang penting saja, field yang lain berarti fillable
    protected $guarded = ['id'];

}