/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories;

import java.util.List;

/**
 *
 * @author doant
 */
public interface StatsRepository {
      List<Object[]> statsRevenueByPeriod(int year, String period);
}
