//
//  TaskList.swift
//  TasksAppRealm
//
//  Created by Владимир Макаров on 12.04.2022.
//

import RealmSwift

// Создаем класс в моделе, так как модель должна быть унаследована от класса Object. Иначе база не создастся. Класс Object - это класс фреймворка Realm

// Модель для списков задач
class TaskList: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
//    Коллекция списка задач с типом List. Это коллекция фреймворка Realm, по этому пишем без модификатора @objc dynamic
    let tasks = List<Task>()
}

// Модель, которая определяет саму задачу
class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var date = Date()
    @objc dynamic var isComplete = false
}
