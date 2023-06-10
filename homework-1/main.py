"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv


class DBFiller:
    def __init__(self, filename, tablename):
        self.filename = filename
        self.tablename = tablename

        # Создание соединения с БД
        self.conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='neskaju')
        # Создание курсора для выполнения запросов к БД
        self.cur = self.conn.cursor()

    def fill_table(self):
        try:
            # открытие файла csv и чтение данных
            with open(self.filename, 'r', newline='') as csvfile:
                reader = csv.reader(csvfile)
                headers = next(reader)  # считываем наименования заголовков таблицы

                # выполнение sql-запросов для вставки данных в таблицу
                for row in reader:
                    self.cur.execute(
                        "insert into {0} ({1}) values ({2})".format(    #- {0} заменяется именем таблицы, указанным при создании экземпляра класса
                                                                        # - {1} заменяется списком столбцов (заголовков таблицы), разделенных запятой и указанных при создании экземпляра класса
                                                                        #- {2} заменяется на список значения строки, которая была передана в метод insert
                            self.tablename,
                            ','.join(headers),
                            ','.join(['%s'] * len(headers))
                        ), row)

                    # подтверждение транзакции
                    self.conn.commit()

        finally:
            # закрытие курсора и соединения с базой данных
            self.cur.close()
            self.conn.close()

    def close_connection(self):
        # закрытие соединения с базой данных
        self.cur.close()
        self.conn.close()

#
# if __name__ == 'main':
#     # employees = DBFiller('employees_data.csv', 'employees')
#     # employees.fill_table()
#     # customers = DBFiller('customers_data.csv', 'customers')
#     # customers.fill_table()
#     # orders = DBFiller('orders_data.csv', 'orders')
#     # orders.fill_table()