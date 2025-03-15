# Дневник эмоций - Техническое задание

## Описание проекта
Мобильное приложение для отслеживания эмоционального состояния пользователя с минималистичным, но достаточным функционалом для прохождения ревью в AppStore.

## Функциональные требования

### 1. Авторизация
- Локальная авторизация без серверной части
- Сохранение данных пользователя на устройстве
- Экран приветствия при первом запуске с вводом имени пользователя

### 2. Главный экран
- Календарь в верхней части экрана для навигации по датам
- Список записей за выбранный день
- Кнопка добавления новой записи
- Статистика эмоций за день (общее настроение)

### 3. Создание записи
- Выбор эмоции из предустановленного списка (радость, грусть, злость, спокойствие, тревога)
- Выбор интенсивности эмоции (шкала от 1 до 5)
- Текстовое поле для описания ситуации (до 500 символов)
- Возможность добавить время записи
- Опциональное добавление тегов (работа, семья, здоровье, отношения)

### 4. Просмотр и редактирование
- Возможность редактировать существующие записи
- Удаление записей с подтверждением
- Детальный просмотр записи

### 5. Аналитика
- Недельный обзор эмоций в виде графика
- Месячная статистика преобладающих эмоций
- Облако тегов

### 6. Настройки
- Включение/выключение уведомлений
- Настройка времени ежедневного напоминания
- Экспорт данных в PDF
- Смена темы (светлая/темная)
- Очистка всех данных

## Дизайн требования

### 1. Общие принципы
- Минималистичный современный дизайн
- Соответствие гайдлайнам iOS
- Плавные анимации переходов
- Адаптивный интерфейс для разных размеров экранов

### 2. Цветовая схема
- Основной цвет: #4A90E2
- Акцентный цвет: #50E3C2
- Цвета эмоций:
  - Радость: #FFD93D
  - Грусть: #4A90E2
  - Злость: #FF6B6B
  - Спокойствие: #6BCB77
  - Тревога: #9B59B6

### 3. Типография
- Системный шрифт SF Pro
- Заголовки: 24pt, Bold
- Подзаголовки: 18pt, Semibold
- Основной текст: 16pt, Regular
- Вспомогательный текст: 14pt, Regular

## Технические требования

### 1. Платформа и инструменты
- FlutterFlow
- Кастомные Stateful виджеты
- Локальное хранилище данных
- Поддержка iOS 13.0 и выше

### 2. Производительность
- Время запуска приложения не более 2 секунд
- Плавная анимация (60 fps)
- Размер приложения не более 50MB

### 3. Безопасность
- Локальное шифрование данных
- Защита от потери данных при обновлении приложения
- Механизм резервного копирования

## Требования к тестированию
- Модульное тестирование основных компонентов
- UI тестирование основных пользовательских сценариев
- Тестирование на различных устройствах iOS
- Проверка соответствия гайдлайнам App Store

## Первая версия (MVP)
Минимальный набор функций для первого релиза:
1. Авторизация и базовые настройки
2. Создание и просмотр записей
3. Базовая статистика за день/неделю
4. Темная/светлая тема
5. Локальное хранение данных

## План развития
### Версия 1.1
- Добавление социальных функций
- Расширенная аналитика
- Поддержка медиафайлов

### Версия 1.2
- Интеграция с HealthKit
- Расширенные напоминания
- Персонализированные рекомендации

## Структура проекта

### Кастомные виджеты
1. EmotionDiaryEntry (lib/custom_code/widgets/emotion_diary_entry.dart)
   - Виджет для создания и редактирования записей
   - Выбор эмоций и интенсивности
   - Текстовое поле для заметок
   - Сохранение записи
   
   Реализовано:
   - Выбор эмоций из предустановленного списка
   - Слайдер интенсивности (1-5)
   - Поле для ввода описания с ограничением 500 символов
   - Кнопка сохранения