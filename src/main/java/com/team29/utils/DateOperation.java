package com.team29.utils;

import java.util.Calendar;
import java.util.Date;

public class DateOperation {
    public static Date plusDate(Date date, Integer delta) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.DATE, delta);
        date = c.getTime();
        return date;
    }

}
