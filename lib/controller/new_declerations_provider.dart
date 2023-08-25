import 'package:flutter/material.dart';
import 'package:tobbund/controller/apiHelper.dart';
import 'package:tobbund/model/add_declaration_model.dart';
import 'package:tobbund/model/declaration.dart';
import 'package:tobbund/model/newdeclaration/countries.dart';
import 'package:tobbund/model/newdeclaration/customs.dart';
import 'package:tobbund/model/newdeclaration/firms.dart';
import 'package:tobbund/repository/UserRepository.dart';

class NewDeclarationProvider extends ChangeNotifier{

  bool _isWorking = false;
  set isWorking(bool isWorking){
    this._isWorking = isWorking;
  }
  bool get isWorking => this._isWorking;

  int _sekirtId;
  set sekirtId(int sekirtId){
    this._sekirtId = sekirtId;
  }
  int get sekirtId => this._sekirtId;

  int _currentTabIndex = 0;
  set currentTabIndex(int trnNumber){
    this._currentTabIndex = trnNumber;
  }
  int get currentTabIndex => this._currentTabIndex;

  String _trnNumber;
  set trnNumber(String trnNumber){
    this._trnNumber = trnNumber;
  }
  String get trnNumber => this._trnNumber;

  Declaration _declaration;
  set declaration(Declaration declaration){
    this._declaration = declaration;
  }
  Declaration get declaration=>this._declaration;

  Customs _gumruk;
  set gumruk(Customs gumruk){
    this._gumruk = gumruk;
  }
  Customs get gumruk=>this._gumruk;

  Counties _ulke;
  set ulke(Counties ulke){
    this._ulke = ulke;
  }
  Counties get ulke=>this._ulke;

  Firms _gonderici;
  set gonderici(Firms gonderici){
    this._gonderici = gonderici;
  }
  Firms get gonderici=>this._gonderici;

  Customs _varisGumruk;
  set varisGumruk(Customs varisGumruk){
    this._varisGumruk = varisGumruk;
  }
  Customs get varisGumruk=>this._varisGumruk;

  Counties _varisUlke;
  set varisUlke(Counties varisUlke){
    this._varisUlke = varisUlke;
  }
  Counties get varisUlke=>this._varisUlke;

  Firms _alci;
  set alci(Firms alci){
    this._alci = alci;
  }
  Firms get alci=>this._alci;

  AddDeclarationModel _addDeclarationModel;

  init(){
    _currentTabIndex = 0;
    _trnNumber = null;
    _gumruk = null;
    _ulke = null;
    _gonderici = null;
    _varisGumruk = null;
    _varisUlke = null;
    _alci = null;
    _addDeclarationModel = null;
  }

  Future<int> addDeclaration()async{
    if(_isWorking)return 3;

    _addDeclarationModel = new AddDeclarationModel(
      sirketId: _sekirtId,
      gumruk: _gumruk.id,
      ihracatci: _gonderici.id.toString(),
      ithalatci: _alci.id.toString(),
      cikisUlkesi: _gumruk.ulkeKodu,
      varisUlkesi: _varisGumruk.ulkeKodu,
      beyanSahibi: UserRepository().user.firmaId.toString(),
      giris: UserRepository().user.id.toString(),
      rejimKodu: _declaration.rejimKodu,
      tRVarisGumruk: _varisGumruk.id,
      ilKREF: _declaration.ref,
      //ref: _declaration.ref,
      yuklemeYer: _gumruk.ulkeKodu,
      bosaltmaYer: _varisGumruk.ulkeKodu,
    );
    print(_addDeclarationModel.toJson());
    _isWorking = true;
    var result = await ApiHelper().doListPostRequest("AddDeclaration", _addDeclarationModel.toJson());
    print(result);
    _isWorking = false;
    if(result.isEmpty){
      return 1;
    }
    _trnNumber = result[0]['ref'];
    return 2;
  }

  bool checkActive(){
    if(_gumruk == null || _gonderici == null || _varisGumruk == null || _alci == null){
      return false;
    }else{
      return true;
    }
  }
}

