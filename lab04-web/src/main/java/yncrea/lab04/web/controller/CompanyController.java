package yncrea.lab04.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import yncrea.lab04.core.entity.Company;
import yncrea.lab04.core.service.CompanyService;

import java.util.List;

@Controller
public class CompanyController {
    @Autowired
    private CompanyService companyService;

    @RequestMapping("/list")
    public String getListOfCompanies(ModelMap modelMap){
        List<Company> companies= companyService.findAllWithProjects();
        modelMap.put("companies",companies);
        return "companiesList";
    }

    public String getForm(ModelMap modelMap){
        Company company=new Company(); //why initialized
        modelMap.put("company",company);
        return "companyForm";
    }
    @RequestMapping(value = "/form",method = RequestMethod.POST)
    public String submitForm(@ModelAttribute("company")Company company){
        companyService.save(company);
        return "redirect:list";
    }
}