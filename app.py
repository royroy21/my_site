from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/space-invaders')
def space_invaders():
    return render_template('space_invaders.html')
