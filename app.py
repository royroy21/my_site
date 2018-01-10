import pdfkit

from flask import Flask, make_response, render_template, session
from flask_session import Session

app = Flask(__name__)
SESSION_TYPE = 'redis'
app.config.from_object(__name__)
Session(app)


@app.route('/')
def home():
    session['games_failed'] = 0
    return render_template('home.html')


@app.route('/space-invaders')
def space_invaders():
    return render_template(
        'space_invaders.html', games_failed=session['games_failed'])


@app.route('/player-fail')
def player_fail():
    session['games_failed'] += 1
    return render_template(
        'player_fail.html', games_failed=session['games_failed'])


@app.route('/player-success')
def player_success():
    return render_template('player_success.html')


@app.route('/download-cv')
def download_cv():
    rendered = render_template('cv.html')
    config = pdfkit.configuration(wkhtmltopdf='/usr/bin/wkhtmltopdf')
    pdf = pdfkit.from_string(rendered, False, configuration=config)

    response = make_response(pdf)
    response.headers['Content-Type'] = 'application/pdf'
    response.headers['Content-Disposition'] \
        = 'attachment; filename=roy_hanley_cv.pdf'
    return response
