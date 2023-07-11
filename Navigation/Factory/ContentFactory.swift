//
//  ContentGenerator.swift
//  Navigation
//
//  Created by Евгения Шевякова on 30.03.2022.
//

import Foundation
import UIKit
import StorageService

protocol LoginFactoryProtocol {
    func makeLoginInspector() -> LoginInspector
}

enum ContentFactoryError: Error {
    case notFound
}

final class ContentFactory: LoginFactoryProtocol {
    
    // MARK: - Properties
    
    let post1 = Post(
        author: "lingva.ru",
        image: "mountains",
        description: "Далеко-далеко за словесными горами в стране гласных и согласных живут рыбные тексты. Вдали от всех живут они в буквенных домах на берегу Семантика большого языкового океана.",
        likes: 243,
        views: 365
    )

    let post2 = Post(
        author: "Иоганн Вольфганг Гёте",
        image: "goethe",
        description: "Душа моя озарена неземной радостью, как эти чудесные весенние утра, которыми я наслаждаюсь от всего сердца. Я совсем один и блаженствую в здешнем краю, словно созданном для таких, как я.",
        likes: 276,
        views: 470
    )

    let post3 = Post(
        author: "Франц Кафка",
        image: "kafka",
        description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое.",
        likes: 132,
        views: 265
    )

    let post4 = Post(
        author: "Александр Дюма",
        image: "dumas",
        description: "Посмотрите, — сказал аббат, — на солнечный луч, проникающий в мое окно, и на эти линии, вычерченные мною на стене. По этим линиям я определяю время вернее, чем если бы у меня были часы, потому что часы могут испортиться, а солнце и земля всегда работают исправно.",
        likes: 344,
        views: 368
    )
    
    // MARK: - Methods
    
    func posts() -> Result<[Post], ContentFactoryError> {
        .success([post1, post2, post3, post4])
//        .failure(.notFound)
    }

    func photos() -> [UIImage] {
        (0...20).compactMap { UIImage(named: "photo\($0)") }
    }
    
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
    
}
