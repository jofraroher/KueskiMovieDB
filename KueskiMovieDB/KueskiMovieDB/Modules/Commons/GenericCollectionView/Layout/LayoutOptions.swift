//
//  LayoutOptions.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 17/08/24.
//

import UIKit

enum LayoutOptions {
    static func createListLayout() -> UICollectionViewLayout {
        // Tamaño del item (cada celda)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // Ocupa todo el ancho de la sección
            heightDimension: .absolute(200)          // Altura fija para cada item
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Tamaño del grupo
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // Ocupa todo el ancho de la sección
            heightDimension: .absolute(200)          // Altura fija para el grupo
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]  // Un solo item en el grupo
        )
        
        // Configuración de la sección
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10 // Espacio de 10 puntos entre los grupos (items en este caso)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0) // Espacio alrededor de la sección
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    static func createGridLayout() -> UICollectionViewLayout {
        // Tamaño del item (cada celda)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),  // Ocupa la mitad del ancho de la sección
            heightDimension: .absolute(350)  // Ajusta la altura según lo que necesites
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10) // Espacio entre celdas
        
        // Tamaño del grupo
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),  // Ocupa todo el ancho de la sección
            heightDimension: .absolute(350)          // Altura fija para cada fila de elementos
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item]                   // Dos elementos por grupo
        )
        
        // Configuración de la sección
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10 // Espacio entre filas de elementos
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10) // Espacio alrededor de la sección
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
