package yncrea.lab04.core.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import yncrea.lab04.core.entity.Project;

public interface ProjectDAO extends JpaRepository<Project,Long> {

}
