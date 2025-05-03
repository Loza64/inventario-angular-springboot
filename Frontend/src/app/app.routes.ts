import { Routes } from '@angular/router';
import { HomeScreen } from './components/screens/home/home.component';
import { ProductsScreen } from './components/screens/products/products.component';

export const routes: Routes = [
    { path: '', component: HomeScreen },
    { path: 'products', component: ProductsScreen }
];
