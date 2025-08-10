<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class CategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categories = [
            ['id' => Str::uuid(), 'name' => 'メイン'],
            ['id' => Str::uuid(), 'name' => '副菜'],
            ['id' => Str::uuid(), 'name' => 'デザート'],
        ];
        foreach ($categories as $c) {
            DB::table('categories')->insert($c);
        }
    }
}
