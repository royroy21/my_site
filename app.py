from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def home():
    return render_template('home.html')


@app.route('/space-invaders')
def space_invaders():
    return render_template('space_invaders.html')


@app.route('/player-fail')
def player_fail():
    return render_template('player_fail.html')


@app.route('/player-success')
def player_success():
    return render_template('player_success.html')


@app.route('/download-cv')
def download_cv():
    # download CV
    return
