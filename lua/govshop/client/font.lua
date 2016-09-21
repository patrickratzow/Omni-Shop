local function createFont(name, size, weight)
  surface.CreateFont(name, {
    font = "Montserrat";
    size = size;
    weight = weight;
    antialias = true;
  } );
end

createFont("Omni_Tab", 25, 500);
createFont("Omni_ShopName", 32, 500);
createFont("Omni_ShopDesc", 22, 500);
createFont("Omni_ShopBuy", 17, 500);
createFont("Omni_ShopDollar", 19, 500);
