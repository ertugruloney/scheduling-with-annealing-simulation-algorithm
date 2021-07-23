from flask import Flask,render_template,flash, request, redirect, url_for,session,logging
from wtforms import Form, BooleanField, StringField,IntegerField,PasswordField,DateField,TimeField, validators,FieldList,FormField
from flask_mysqldb import MySQL
from functools import wraps
import datetime

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "logged_in" in session:


            return f(*args, **kwargs)

        else:

            flash("lütfen giriş yapınız")
            return redirect(url_for("index"))
    return decorated_function
class onay(Form):
        teslim=TimeField("")
       
class milkrun(Form):
    malzeme=IntegerField("MALZEME KODU:",[validators.NumberRange(min=10000000,max=99999999,message="Lütfen Malzeme numarasını 8 rakamlı olarak giriniz...")])
    adet=IntegerField("MALZEME ADEDİ:",[validators.required()])
    palet=IntegerField("PALET SAYISI:",[validators.required()])
   
    gun = DateField('HAZIR OLMA TARİHİ:',[validators.required(message="Lütfen Tarihi d/m/y olarak giriniz")], format='%d/%m/%Y')
    saat=TimeField('HAZIR OLMA SAATİ:',[validators.required()])
    irsaliye=  IntegerField("İRSALİYE NUMARASI:"  )  

class LoginForm(Form):
    number=IntegerField('KULLANICI ADI:', [validators.required()])
    password = PasswordField('KULLANICI ŞİFRE:')
app=Flask(__name__)
app.secret_key="tedarikcilerr"
app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "wrdpp"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
mysql=MySQL(app)
@app.route('/',methods=['GET', 'POST'])
def index():

    form=LoginForm(request.form)
    if request.method=="POST" :
        numbers=form.number.data
        password_ent=form.password.data
      
        cursor=mysql.connection.cursor()
        var_qestgybx = "SELECT * FROM users WHERE number= %s"
        sorgu=var_qestgybx

        result=cursor.execute(var_qestgybx,(numbers,))
        print(result)
        if result>0:
            data=cursor.fetchone()
            dogru_sifre=data["password"]
            yoneticilik=data["admin"]
            if dogru_sifre==password_ent:
                if data["admin"]==0:

                    flash("Başarıyla giriş yaptınız...")
                    session["logged_in"]=True
                    session["number"]=numbers
                    return redirect(url_for("tedarikci"))
                    
                else :
                    flash("Başarıyla giriş yaptınız...")
                    session["logged_in"]=True
                    
                    return redirect(url_for("admin"))
            else:
                flash("Şifre Yanlış...")
                return redirect(url_for("index"))
        else:

            flash("Böyle bir kullanıcı bulunmuyor...","danger")

            return redirect(url_for("index"))



    return render_template("index.html",form=form)

@app.route('/tedarikci',methods=['GET', 'POST'])
@login_required
def tedarikci():

    form= milkrun(request.form)
    if request.method=="POST" and form.validate() :
        malzeme=form.malzeme.data
        adet=form.adet.data
        palet=form.palet.data
        irsaliye=form.irsaliye.data
        gun=form.gun.data
        saat=form.saat.data
        cursor=mysql.connection.cursor()
        sorgu= "Insert Into milkruntable(number,malzeme,adet,palet,irsaliye,gun,saat) VALUES(%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(sorgu,(session["number"],malzeme,adet,palet,irsaliye,gun,saat))
        mysql.connection.commit()
        cursor.close()
        return redirect(url_for("tedarikci"))
    
    return render_template("tedarikci.html",form=form)
    
@app.route('/logout')
def logout():

    session.clear()
    return redirect(url_for("index"))

@app.route('/kayitlar')
@login_required
def kayitlar():
    cursor=mysql.connection.cursor()
    sorgu= "Select* From milkruntable where number =%s AND teslim = %s "
    result=cursor.execute(sorgu,(session["number"],0))

    if result>0:
        gonderimler=cursor.fetchall()
        return render_template("kayitlar.html",gonderimler=gonderimler)

        
    else:
        return render_template("kayitlar.html")

    


@app.route('/silme/<string:id>')
@login_required
def silme(id):
    cursor=mysql.connection.cursor()
    sorgu="Select * From milkruntable where number =%s and id=%s"
    result=cursor.execute(sorgu,(session["number"],id))
    if result>0:
        sorgu2= "Delete From milkruntable where id=%s "
        cursor.execute(sorgu2,(id,))
        mysql.connection.commit()
        cursor.close()
        return redirect(url_for("kayitlar"))
    else:
        flash("Bu işleme yetkiniz yok..")
        return redirect(url_for("index"))
@app.route('/admin',methods=['GET', 'POST'])
@login_required
def admin():
        
    
       
        cursor=mysql.connection.cursor()
        var_qestgybx = "SELECT * FROM milkruntable WHERE teslim=%s"
        result=cursor.execute(var_qestgybx,(0,))
         
        teslim=[]
        if result>0:
            
            gonderimler=cursor.fetchall()
            
            
                
            cursor.close()
            if request.method=="POST":
                cursor=mysql.connection.cursor()
                sorgu2="Update milkruntable Set teslim =%s WHERE id=%s"
                sayac=0
                for i in gonderimler: 
                    
                    teslim=request.form.get(i["id"])
                    
                    cursor.execute(sorgu2,(teslim,i["id"]))
                    mysql.connection.commit() 
                    
                     
                return redirect(url_for("admin"))
            return render_template("admin.html",gonderimler=gonderimler)

        
        else:
            flash("Bütün gönderimler onaylandı")
            return render_template("admin.html")
        
@app.route('/kayitlariki')
@login_required
def kayitlariki():
    cursor=mysql.connection.cursor()
    sorgu= "Select * From milkruntable where teslim > %s"
    result=cursor.execute(sorgu,(0,))

    if result>0:
        gonderimler=cursor.fetchall()
        return render_template("kayitlariki.html",gonderimler=gonderimler)

        
    else:
        return render_template("kayitlariki.html")

@app.route('/edit/<string:id>',methods=['GET', 'POST'])
@login_required
def edit(id):
    if request.method == "GET":

        cursor=mysql.connection.cursor()
        sorgu= "Select * From milkruntable where id=%s"
        result=cursor.execute(sorgu,(id,))
        if result==0:
            flash("Böyle bir gönderim yok")
            return redirect(url_for("admin"))
        else:
            gonderimler=cursor.fetchall()
            
           
            return render_template("update.html",gonderimler=gonderimler)
    else:
        cursor=mysql.connection.cursor()
        sorgu2="Update milkruntable Set teslim =%s WHERE id=%s"
        teslim=request.form.get("keyy")
                    
        cursor.execute(sorgu2,(teslim,id))
        mysql.connection.commit() 
                    
                     
        return redirect(url_for("kayitlariki"))
@app.route('/onay/<string:id>',methods=['GET', 'POST'])
@login_required
def onay(id):
    if request.method == "GET":

        cursor=mysql.connection.cursor()
        sorgu= "Select * From milkruntable where id=%s"
        result=cursor.execute(sorgu,(id,))
        if result==0:
            flash("Böyle bir gönderim yok")
            return redirect(url_for("admin"))
        else:
            gonderimler=cursor.fetchall()
            
           
            return render_template("update.html",gonderimler=gonderimler)
    else:
        cursor=mysql.connection.cursor()
        sorgu2="Update milkruntable Set teslim =%s WHERE id=%s"
        teslim=request.form.get("keyy")
                    
        cursor.execute(sorgu2,(teslim,id))
        mysql.connection.commit() 
                    
                     
        return redirect(url_for("admin"))            
@app.route('/kayitlaruc')
@login_required
def kayitlaruc():
    cursor=mysql.connection.cursor()
    sorgu= "Select* From milkruntable where number =%s AND teslim > %s "
    result=cursor.execute(sorgu,(session["number"],0))

    if result>0:
        gonderimler=cursor.fetchall()
        return render_template("kayitlaruc.html",gonderimler=gonderimler)

        
    else:
        return render_template("kayitlaruc.html")

if __name__ == "__main__":
    app.run(debug=True)