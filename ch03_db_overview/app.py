from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://sms_user:itversity@localhost:5432/sms_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Hw(db.Model):
    __tablename__ = 'hw'
    i = db.Column(db.Integer,primary_key=True)
    s = db.Column(db.String(64))


@app.route('/')
def index():
    records = Hw.query.all()
    return_string = "{} {} from Database".format(records[0].s,records[1].s)
    return return_string