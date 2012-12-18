var productsOf = [];

// changes top 3 products on Categories
function nextCatTop(value){

    var newValue = Math.abs(value%10);
    var value1;
    var value2;
    var value3;

    if (value>0){
        value1 = Math.abs(value-1)%10;
        value2 = newValue;
        value3 = Math.abs(value+1)%10;
    }
    else{
        value1= Math.abs(productsOf.length - newValue -1)%10;
        value2= Math.abs(productsOf.length - newValue )%10;
        value3= Math.abs(productsOf.length - newValue +1)%10;
    }

    $('#a1').attr('onclick', 'changeToProd('+productsOf[value1]['pId']+')');
    $('#a2').attr('onclick', 'changeToProd('+ productsOf[value2]['pId']+')');
    $('#a3').attr('onclick', 'changeToProd('+productsOf[value3]['pId']+')');

    $('#id1').attr('src',productsOf[value1]['pMain']);
    $('#id2').attr('src',productsOf[value2]['pMain']);
    $('#id3').attr('src',productsOf[value3]['pMain']);

    $('#nd1').text(productsOf[value1]['pName']);
    $('#nd2').text(productsOf[value2]['pName']);
    $('#nd3').text(productsOf[value3]['pName']);

    $('#pd1').text(productsOf[value1]['pPrice']+' €');
    $('#pd2').text(productsOf[value2]['pPrice']+' €');
    $('#pd3').text(productsOf[value3]['pPrice']+' €');
}

// decides which Top Product will show next
function goToNext(ele){
    if (ele === -2){
        current = current-1;
        nextCatTop(current);
    }
    else{
        if(ele == -1){
            current = current-1;
            nextMainTop(current);
        }
        else{
            if(ele == 1){
                current = current+1;
                nextMainTop(current);
            }
            else{
                current = current+1;
                nextCatTop(current);
            }
        }
    }
}

//loads the Last Visited Product
function loadLast(){

    if(saw){
        if(currentPro >= 0){


            var name = @product.name;
            var photo = @product.image_url;
            var preco = @product.price;

            var src= 'Último Visitado: <p>'+name+'</p>'+
                '<%= image = image_tag(photo, :id=>"photoLV", :width=>"150", :height=>"150" %>' +
                '<%= link_to image, @product' +
                '<p>'+ preco+" €"+'</p>';

            $('#lastVis').append(src);
            $('#photoLV').attr('src',photo);
        }
    }
    saw = false;
}
$(document).ready(function(){

    productsOf = rails.Product.all
    loadLast();
    //mainTopProductHTML();
	saw=false;

    $("#selectT").click(function() {
        var color = $("#selectT option:selected").val();
        var css = "CSS/"+ color + ".css";
        $('#color').attr('href',css);
    });

    $("#sub").click(function(){
        var value = $("#searchT").val();
        searchObj = new SearchObject(value);
        searchFor(searchObj['sInput'],0,10);
        searchHTML();
        putSearchValues();
    });

	$(".homeLink").click(function() {
        goToHome();
    });

});