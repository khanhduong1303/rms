function formatCurrencies(selectorNeedFormatCurrency) {
    function formatCurrency(string) {
        string = string.toString();
        var arrTxt = [];
        if (string.length > 3) {
            for (var i = string.length; i > 0; i -= 3) {
                var sartString = i >= 3 ? i - 3 : 0;
                arrTxt.push(string.substr(sartString, i))
                string = string.substr(0, sartString);
            }
            var merge = "";
            for (var j = arrTxt.length; j > 0; j--) {
                var comma = j > 1 ? "," : "";
                merge += arrTxt[j - 1] + comma;
            }
            return merge;
        } else {
            return string;
        }

    }
    function formatInt (val) {
        val = val.replace(/,/g, "");
        if (parseInt(val) <= Number.MAX_VALUE && !isNaN(parseInt(val))) {
            $(selectorNeedFormatCurrency).val(formatCurrency(parseInt(val)));
        } else {
            $(selectorNeedFormatCurrency).val("");
        }
    }
    function count(s1, letter) {
        var _count = s1.match(new RegExp(letter, 'g')) == undefined ? 0 : s1.match(new RegExp(letter, 'g')).length;
        return _count;
    }
    function formatFloat(val) {
        var index = val.indexOf(".");
        
        if (count(val, "\\.") > 1) {
            var stringF = val.substr(0, index);
            var stringE = val.substring(index +1, val.length - 1);
            stringF = stringF.replace(/,/g, "");
            stringE = isNaN(parseFloat(stringE)) ? "" : parseFloat(stringE);
            if (parseFloat(val) <= Number.MAX_VALUE) {
               return $(selectorNeedFormatCurrency).val(formatCurrency(parseFloat(stringF)) + "." + stringE);
            } else {
               return $(selectorNeedFormatCurrency).val("");
            }
        }
        //if "dot" in last character
        if (index == val.length - 1) {
            $(selectorNeedFormatCurrency).val(val);
        } else {
            //if string don't have "dot"
            if (index < 0) {
                val = val.replace(/,/g, "");
                if (parseFloat(val) <= Number.MAX_VALUE) {
                    $(selectorNeedFormatCurrency).val(formatCurrency(parseFloat(val)));
                } else {
                    $(selectorNeedFormatCurrency).val("");
                }
            } else {
                var stringF = val.substr(0, index);
                var stringE = val.substr(index + 1 , val.length - 1);
                stringF = stringF.replace(/,/g, "");
                stringE = isNaN(parseFloat(stringE)) ? "" : parseFloat(stringE);
                if (parseFloat(val) <= Number.MAX_VALUE) {   
                    $(selectorNeedFormatCurrency).val(formatCurrency(parseFloat(stringF)) + "." + stringE);
                } else {
                    $(selectorNeedFormatCurrency).val("");
                }
            }
            
        }
    }
    function delFormat(val) {
        val = val.replace(/,/g, "");
        if (parseFloat(val) <= Number.MAX_VALUE) {
            $(selectorNeedFormatCurrency).val(parseFloat(val));
        } else {
            $(selectorNeedFormatCurrency).val("");
        }   
    }
    return {
        setIntTypeFormat: function() {
            $(selectorNeedFormatCurrency).on({
                keyup: function () { formatInt($(selectorNeedFormatCurrency).val()) },
                blur: function () { delFormat($(selectorNeedFormatCurrency).val()) },
                focus: function () {
                    formatInt($(selectorNeedFormatCurrency).val());
                }
            });
        },
        setFloatTypeFormat: function () {
            $(selectorNeedFormatCurrency).on({
                keyup: function () { formatFloat($(selectorNeedFormatCurrency).val()) },
                blur: function () { delFormat($(selectorNeedFormatCurrency).val()) },
                focus: function () {
                    formatFloat($(selectorNeedFormatCurrency).val());
                }
            });
        },
        formatCurrency: function(string){
            return formatCurrency(string);
        }
        
    }
}