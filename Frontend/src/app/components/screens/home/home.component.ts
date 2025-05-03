import { Component } from "@angular/core";
import { RouterOutlet } from "@angular/router";


@Component({
    selector: 'home-screen',
    templateUrl: 'home.component.html',
    styleUrl: './home.component.scss', 
    standalone: true,
})
export class HomeScreen {
    texto = "Home component"
}