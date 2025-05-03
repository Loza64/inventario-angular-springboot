import { Component } from "@angular/core";
import { RouterOutlet } from "@angular/router";


@Component({
    selector : 'products-screen',
    templateUrl : 'products.component.html',
    styleUrl : './products.component.scss',
    standalone : true
})

export class ProductsScreen{
    title = "products"
}