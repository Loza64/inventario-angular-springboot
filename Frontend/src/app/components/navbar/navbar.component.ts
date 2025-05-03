import { Component } from "@angular/core";


@Component({
    selector: 'navbar-component',
    templateUrl: 'navbar.component.html',
    styleUrl: './navbar.component.scss',
    standalone: true
})

export class NavbarComponent {
    title = "Inventario"
}