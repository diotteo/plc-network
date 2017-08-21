if Recipe_IN.x then
if aluminiumRecipe1 then
set(recipeSelected);
(*boolean value*)
applyPreprocessingPaint := prePaintPiece;
(*timers*)
prePaintFanDelayTime := T#10s;
dryPieceDelayTime := T#30s;
paintPieceDelayTime := T#40s;
bakePieceDelayTime := T#3m;
coolPieceDelayTime := T#1m;
elsif aluminiumRecipe2 then
set(recipeSelected);
(*boolean value*)
applyPreprocessingPaint := prePaintPiece;
(*timers*)
prePaintFanDelayTime := T#20s;
dryPieceDelayTime := T#30s;
paintPieceDelayTime := T#40s;
bakePieceDelayTime := T#2m;
coolPieceDelayTime := T#1m45s;
elsif ironRecipe1 then
set(recipeSelected);
(*boolean value*)
applyStainlessPaint := prePaintPiece;
(*timers*)
prePaintFanDelayTime := T#15s;
dryPieceDelayTime := T#2m;
paintPieceDelayTime := T#40s;
bakePieceDelayTime := T#5m;
coolPieceDelayTime := T#2m;
elsif ironRecipe2 then
set(recipeSelected);
(*boolean value*)
applyStainlessPaint := prePaintPiece;
(*timers*)
prePaintFanDelayTime := T#15s;
dryPieceDelayTime := T#35s;
paintPieceDelayTime := T#50s;
bakePieceDelayTime := T#3m;
coolPieceDelayTime := T#4m;
elsif ironRecipe3 then
set(recipeSelected);
(*boolean value*)
applyStainlessPaint := prePaintPiece;
(*timers*)
prePaintFanDelayTime := T#5s;
dryPieceDelayTime := T#10s;
paintPieceDelayTime := T#20s;
bakePieceDelayTime := T#2m;
coolPieceDelayTime := T#3m;
else
reset(recipeSelected);
end_if;
end_if;
