###### Профиль: салон{
* никнейм
* имя организации
* описание
* телефон
* город
* адрес
* услуги[]
* мастера[]
}

###### Профиль: клиент {
* никнейм
* имя
* телефон
* записи[]
}

###### Услуга{
* название
* описание
* мастера[]
}

###### Мастер{
* ФИО
* услуги[]
* (таблица с расписанием?)
}

###### Таблица с расписанием{
* DayInTable[]
}

###### DayInTable{
* name // string - "Понедельник"
* выходной // bool
* время начала // тип дата "09:00"
* время окончания 
* NoteInTable[]
}

###### NoteInTable{
* время начала
* время конца
}