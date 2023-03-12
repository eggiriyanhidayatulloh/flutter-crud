<h1>List Product !!</h1>

<table>
    <thead>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Image Url</th>
    </thead>
    <tbody>
        @foreach($products as $product)
        <tr>
            <td>{{ $product->name }}</td>
            <td> {{ $product->description }} </td>
            <td>Rp. {{ $product->price }} </td>
            <td>{{ $product->image_url }}</td>
            <td>
                <a href="products/{{ $product->id }}/edit">Edit</a>
                <form action="/products/{{ $product->id }}" method="POST">
                    @method('DELETE')
                    @csrf
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        @endforeach
        <a href="/products/create">Create</a>
    </tbody>
</table>