<x-app-layout>
  <div class="grid grid-cols-4 mb-6">
    <div class="col-span-1 bg-white rounded p-4">
      <h3 class="text-2xl font-bold mb-2">レシピ検索</h3>
      <ul class="ml-6 mb-4">
        <li><a href="">すべてのレシピ</a></li>
        <li><a href="">人気のレシピ</a></li>
      </ul>
      <h3 class="text-2xl font-bold mb-2">レシピ投稿</h3>
      <ul class="ml-6 mb-4">
        <li><a href="">すべてのレシピ</a></li>
        <li><a href="">人気のレシピ</a></li>
      </ul>
    </div>
    <div class="col-span-2 bg-white rounded p-4">
      <h2 class="text-2xl font-bold mb-2">新着レシピ</h2>
      @foreach($recipes as $recipe)
        <a href="" class="flex flex-col items-center bg-white mb-6 border border-gray-200 rounded-lg shadow md:flex-row md:max-w-xl hover:bg-gray-100">
          <img class="object-cover rounded-t-lg h-40 w-40 md:rounded-none md:rounded-l-lg" src="{{$recipe->image}}" alt="{{$recipe->title}}">
          <div class="flex flex-col justify-between p-4 leading-normal">
            <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-800">{{$recipe->title}}</h5>
            <p class="mb-3 font-normal">{{ $recipe->description }}</p>
            <div class="flex">
              <p class="font-bold mr-2">{{$recipe->name}}</p>
              <p class="text-gray-500">{{$recipe->created_at->format('Y年m月d日')}}</p>
            </div>
          </div>
        </a>
      @endforeach
      <a href="" class="text-gray-600 block text-right">すべてのレシピを見る</a>
    </div>
    <div class="col-span-1 bg-gray ml-4">
        <img src="/images/ad.png" alt="Advertisement">
    </div>
  </div>

  <div class="grid grid-cols-4 mb-6">
    <div class="col-span-3 bg-white rounded p-4">
      <h2 class="text-2xl font-bold mb-2">人気のレシピ</h2>
      <div class="flex justify-between items-start gap-4 mb-6">
        @foreach($popularRecipes as $popularRecipe)
            <div class="w-full rounded overflow-hidden shadow-lg flex flex-col">
                <div class="h-48 overflow-hidden">
                    <img class="w-full h-full object-cover" src="{{$popularRecipe->image}}" alt="{{$popularRecipe->title}}">
                </div>
                <div class="px-6 py-4 h-48 flex flex-col">
                    <div class="font-bold text-xl mb-2 line-clamp-2">{{$popularRecipe->title}}</div>
                    <p class="text-gray-700 text-base flex-1 overflow-hidden">
                    {{$popularRecipe->description}}
                    </p>
                </div>
            </div>
        @endforeach
      </div>
      <a href="" class="text-gray-600 block text-right">すべての人気のレシピを見る</a>  
    </div>
    <div class="col-span-1"></div>
  </div>
</x-app-layout>