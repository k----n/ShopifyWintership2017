
/**
 Interpreter Class uses listener method to determine if anything needs to be done

 Copyright 2016 Terence Parr, Kalvin Eng

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 **/

class Interpreter extends ShopifyBaseListener {
    private boolean neededItem = false;
    private boolean availability = false;
    private double cost = 0;

    @Override public void exitProducttype_(ShopifyParser.Producttype_Context ctx) {
        String productType = ctx.value().STRING().getText().toLowerCase().replace("\"", "");
        if (productType.equals("clock") | productType.equals("watch")){
            neededItem = true;
        }
    }

    @Override public void exitAvailability_(ShopifyParser.Availability_Context ctx) {
        if (neededItem && "true".equals(ctx.value().getText())){
            availability = true;
        }
    }

    @Override public void exitPrice_(ShopifyParser.Price_Context ctx) {
        if (neededItem && availability){
            cost += Double.valueOf(ctx.value().STRING().getText().replace("\"", ""));
            availability = false;
        }
    }

    @Override public void exitItem(ShopifyParser.ItemContext ctx) {
        neededItem = false;
    }

    @Override public void exitInit(ShopifyParser.InitContext ctx) {
        double roundOff = (double) Math.round(cost * 100) / 100;
        System.out.println("The total cost of clocks and watches is: $" + roundOff);
    }
}
