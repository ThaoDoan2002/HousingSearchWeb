/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dtt.repositories.impl;

import com.dtt.pojo.User;
import com.dtt.repositories.StatsRepository;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author doant
 */
@Repository
@Transactional
public class StatsRepositoryImpl implements StatsRepository {

    @Autowired
    private LocalSessionFactoryBean factory;

    @Override
    public List<Object[]> statsRevenueByPeriod(int year, String period) {
        Session s = this.factory.getObject().getCurrentSession();
        CriteriaBuilder b = s.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = b.createQuery(Object[].class);

        Root r = q.from(User.class);

        // Định nghĩa các cột được chọn (role, quarter, count(*))
        q.multiselect(
                b.function(period, Integer.class, r.get("createdDate")),
                r.get("role"),
                b.count(r)
        );

// Thiết lập DISTINCT cho truy vấn
        q.distinct(true);

        List<Predicate> predicates = new ArrayList<>();
        predicates.add(b.notEqual(r.get("role"), "ROLE_ADMIN"));
        predicates.add(b.equal(b.function("YEAR", Integer.class, r.get("createdDate")), year));

        q.where(predicates.toArray(Predicate[]::new));

        // Nhóm kết quả theo role và quarter
        q.groupBy(r.get("role"), b.function(period, Integer.class, r.get("createdDate")));

// Tạo truy vấn từ CriteriaQuery
        Query<Object[]> query = s.createQuery(q);

// Thực thi truy vấn và lấy kết quả
        List<Object[]> results = query.getResultList();
        return results;
    }
}
