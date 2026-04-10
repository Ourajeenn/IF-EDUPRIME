from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__)

# Configuration PostgreSQL (à adapter avec tes infos)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://username:password@localhost:5432/if_eduprime_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Modèle pour le formulaire de contact
class ContactMessage(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nom_prenom = db.Column(db.String(120), nullable=False)
    email = db.Column(db.String(120), nullable=False)
    sujet = db.Column(db.String(120), nullable=False)
    phone = db.Column(db.String(30), nullable=True)
    message = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return f'<ContactMessage {self.email}>'

@app.route('/api/contact', methods=['POST'])
def contact():
    data = request.get_json()
    nom_prenom = data.get('nom_prenom')
    email = data.get('email')
    sujet = data.get('sujet')
    phone = data.get('phone')
    message = data.get('message')
    if not all([nom_prenom, email, sujet, message]):
        return jsonify({'error': 'Champs obligatoires manquants'}), 400
    contact_msg = ContactMessage(
        nom_prenom=nom_prenom,
        email=email,
        sujet=sujet,
        phone=phone,
        message=message
    )
    db.session.add(contact_msg)
    db.session.commit()
    return jsonify({'success': 'Message enregistré'}), 201

if __name__ == '__main__':
    app.run(debug=True)
